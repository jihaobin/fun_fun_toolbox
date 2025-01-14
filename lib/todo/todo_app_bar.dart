import 'package:flutter/material.dart';

import '../componts/dropdown_selector.dart';
import 'model/todo_Item_model.dart';

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget{

  final DropdownSelectorModel<TodoType> currentCategory;

  final List<DropdownSelectorModel<TodoType>> categories;

  final void Function(DropdownSelectorModel<TodoType>? value) onCategoryChanged;

  final VoidCallback onAddTodo;

  final TextEditingController controller;

  const TodoAppBar({super.key, required this.currentCategory, required this.categories, required this.onCategoryChanged, required this.onAddTodo, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: controller,
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
        onEditingComplete: onAddTodo,
      ),
      actions: [
        IconButton(
          onPressed: onAddTodo,
          icon: const Icon(
            Icons.add_circle_outline_sharp,
            color: Colors.blue,
          ),
        ),
        DropdownSelector(
          value: currentCategory, items: categories,onChanged: onCategoryChanged,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
