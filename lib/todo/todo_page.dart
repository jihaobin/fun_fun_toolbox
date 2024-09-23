import 'package:flutter/material.dart';
import 'package:fun_toolbox/todo/todo_app_bar.dart';
import 'package:fun_toolbox/todo/todo_dialog.dart';
import 'package:fun_toolbox/todo/todo_item.dart';
import 'package:uuid/uuid.dart';

import '../componts/dropdown_selector.dart';
import 'model/todo_Item_model.dart';

final List<DropdownSelectorModel<TodoType>> categories = [
  DropdownSelectorModel(selectedName: '全部', selectedType: TodoType.noSet),
  DropdownSelectorModel(selectedName: '学习', selectedType: TodoType.learn),
  DropdownSelectorModel(selectedName: '生活', selectedType: TodoType.life),
  DropdownSelectorModel(selectedName: '工作', selectedType: TodoType.work),
];


class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with AutomaticKeepAliveClientMixin{
  late DropdownSelectorModel<TodoType> currentCategory;

  List<TodoItemModel> todos = [
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办1',
        type: TodoType.noSet,
    ),
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办2',
        type: TodoType.learn,
        progress: 1
    ),
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办3',
        type: TodoType.life,
        progress: 0.5
    ),
    TodoItemModel(id: const Uuid().v4(), title: '待办4', type: TodoType.work),
  ];

  TextEditingController controller = TextEditingController();

  final TextEditingController dialogTitleController = TextEditingController();

  final TextEditingController dialogSubTitleController =
      TextEditingController();

  final dialogProgressController = TextEditingController();

  late DropdownSelectorModel<TodoType> dialogCurrentCategory;


  @override
  void initState() {
    super.initState();
    currentCategory = categories[0];
    dialogCurrentCategory = categories[0];
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppBar(
        controller: controller,
        currentCategory: currentCategory,
        categories: categories,
        onCategoryChanged: (DropdownSelectorModel<TodoType>? value) {
          // 对当前的Todos列表进行分类
          if (value != null) {
            currentCategory = value;
            setState(() {});
          }
        },
        onAddTodo: onAddSimpleTodo,
      ),
      body: ListView.builder(
        itemCount: categoryTodo.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoItem(
            deleteTodo: () {
              todos.removeAt(index);
              setState(() {});
            },
            todo: categoryTodo[index],
            onUpdateTodo: (){
              updateDetailTodoDialog(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blue,
        onPressed: addDetailTodoDialog,
        tooltip: "添加TODO",
        child: const Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.white,
        ),
      ),
    );
  }

  void onAddSimpleTodo() {
    if (controller.text.isEmpty) {
      return;
    }

    todos = [
      TodoItemModel(
        id: const Uuid().v4(),
        title: controller.text,
      ),
      ...todos
    ];

    controller.text = "";
    setState(() {});
  }

  List<TodoItemModel> get categoryTodo {
    if (currentCategory.selectedType == TodoType.noSet) {
      // 如果当前分类的类型为未设置，则直接返回所有待办事项
      return todos;
    }
    // 否则，筛选出类型与当前分类相同的待办事项，并将其存入列表中
    return todos
        .where((element) => element.type == currentCategory.selectedType)
        .toList();
  }

  void addDetailTodoDialog() async {
    await showDetailDialog(addDetailTodo);
  }

  Future<void> showDetailDialog(VoidCallback onConfirm,{String confirmText = "确定"}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TodoDialogBuilder(
          onConfirm: onConfirm,
          dialogTitleController: dialogTitleController,
          currentCategory: dialogCurrentCategory,
          dialogProgressController: dialogProgressController,
          dialogSubTitleController: dialogSubTitleController,
        );
      },
    );
  }

  void clearTodoDetail(){
  dialogTitleController.text = "";
  dialogSubTitleController.text = "";
  dialogProgressController.text = "";
  dialogCurrentCategory = categories[0];
  }

  void addDetailTodo() {
    todos = [
      TodoItemModel(
        id: const Uuid().v4(),
        title: dialogTitleController.text,
        subTitle: dialogSubTitleController.text,
        progress: double.parse(dialogProgressController.text) / 100,
        type: dialogCurrentCategory.selectedType,
      ),
      ...todos
    ];
    clearTodoDetail();
    setState(() {});
  }

  void updateDetailTodoDialog(int index) async{
    dialogSubTitleController.text = todos[index].subTitle;
    dialogTitleController.text = todos[index].title;
    dialogProgressController.text = ((todos[index].progress) * 100).toInt().toString();
    dialogCurrentCategory = categories.firstWhere((element) => element.selectedType == todos[index].type);
    await showDetailDialog(confirmText: "编辑",(){
      updateDetailTodo(index);
    });

    clearTodoDetail();
  }
  void updateDetailTodo(int index) {
    todos[index].progress = double.parse(dialogProgressController.text) / 100;
    todos[index].subTitle = dialogSubTitleController.text;
    todos[index].title = dialogTitleController.text;
    todos[index].type = dialogCurrentCategory.selectedType;
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

}
