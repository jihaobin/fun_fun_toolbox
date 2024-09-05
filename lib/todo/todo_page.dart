import 'package:flutter/material.dart';
import 'package:fun_toolbox/todo/todo_app_bar.dart';
import 'package:fun_toolbox/todo/todo_item.dart';
import 'package:uuid/uuid.dart';

import 'model/todo_Item_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late CategoriesModel currentCategory;
  List<CategoriesModel> categories = [
    CategoriesModel(TodoType.noSet, "全部"),
    CategoriesModel(TodoType.work, "工作"),
    CategoriesModel(TodoType.learn, "学习"),
    CategoriesModel(TodoType.life, "生活")
  ];
  List<TodoItemModel> todos = [
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办1',
        type: TodoType.noSet,
        status: CompletionStatus.notCompleted),
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办2',
        type: TodoType.learn,
        status: CompletionStatus.completed),
    TodoItemModel(
        id: const Uuid().v4(),
        title: '待办3',
        type: TodoType.life,
        status: CompletionStatus.progressing),
    TodoItemModel(id: const Uuid().v4(), title: '待办4', type: TodoType.work),
  ];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentCategory = categories[0];
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
        onCategoryChanged: (CategoriesModel? value) {
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blue,
        onPressed: () {},
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
          title: controller.text,),
      ...todos
    ];

    controller.text = "";
    setState(() {});
  }

  List<TodoItemModel> get categoryTodo {
    if(currentCategory.type == TodoType.noSet) {
      // 如果当前分类的类型为未设置，则直接返回所有待办事项
      return todos;
    }
    // 否则，筛选出类型与当前分类相同的待办事项，并将其存入列表中
    return todos.where((element) => element.type == currentCategory.type).toList();
  }
}
