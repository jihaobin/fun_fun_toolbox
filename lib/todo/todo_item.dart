import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:progress_border/progress_border.dart';

import 'model/todo_Item_model.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.deleteTodo, required this.todo});

  final VoidCallback deleteTodo;
  final TodoItemModel todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          color: getTodoTypeColor(todo.status),
          // 添加阴影
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2), // 阴影偏移
              blurRadius: 4, // 阴影模糊程度
            )
          ]),
      child: Slidable(
        key: ValueKey(todo.id.toString()),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                deleteTodo();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: '删除',
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          leading: progressCircle(),
          title: Text(todo.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(todo.subTitle,style: TextStyle(color: Colors.grey.shade200),),
          trailing: Container(
            constraints: const BoxConstraints(maxWidth: 50),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ), // 设置内边距
              ),
              onPressed: () {},
              child: const Text(
                "编辑",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container progressCircle() {
    return Container(
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
            progress: todo.progress,
          ),
        ),
        child: Text(
          getTodoType(todo.type),
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  String getTodoType(TodoType type) {
    switch (type) {
      case TodoType.life:
        return "生活";
      case TodoType.work:
        return "工作";
      case TodoType.noSet:
        return "待定";
      case TodoType.learn:
        return "学习";
      default:
        return "待定";
    }
  }

  Color getTodoTypeColor(CompletionStatus state) {
    switch (state) {
      case CompletionStatus.completed:
        return const Color(0xFF28A745);
      case CompletionStatus.notCompleted:
        return const Color(0xFFC1167F);
      case CompletionStatus.progressing:
        return const Color(0xFFFFC107);
    }
  }
}
