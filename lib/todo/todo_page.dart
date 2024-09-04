import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:progress_border/progress_border.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String currentCategory = '全部';
  List<String> categories = ['全部', '工作', '学习', '生活'];
  List<String> todos = ['待办事项1', '待办事项2', '待办事项3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF3F6F9),
            constraints: BoxConstraints(maxHeight: 35),
            border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            hintText: "请输入需要添加的待办事项",
            hintStyle: TextStyle(fontSize: 14),
          ),
          onEditingComplete: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.blue,
            ),
          ),
          DropdownButton<String>(
            value: currentCategory,
            items: categories.map((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (Object? value) {
              currentCategory = value.toString();
              setState(() {});
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    // 删除操作
                    todos.removeAt(index);
                    setState(() {});
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: '删除',
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.3), width: 3))),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                leading: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 80,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: ProgressBorder.all(
                        color: Colors.blue,
                        width: 3,
                        progress: 1,
                      ),
                    ),
                    child: const Text(
                      "学习",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                title: Text(todos[index]),
                trailing: Container(
                  constraints: const BoxConstraints(maxWidth: 50),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,), // 设置内边距
                    ),
                    onPressed: () {},
                    child: const Text("编辑"),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
