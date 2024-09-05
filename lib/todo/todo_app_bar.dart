import 'package:flutter/material.dart';

import 'model/todo_Item_model.dart';

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget{

  final CategoriesModel currentCategory;

  final List<CategoriesModel> categories;

  final void Function(CategoriesModel? value) onCategoryChanged;

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
        DropdownButton<CategoriesModel>(
          value: currentCategory,
          items: categories.map((
              CategoriesModel value,) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.categoryName),
            );
          }).toList(),
          onChanged:onCategoryChanged
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
