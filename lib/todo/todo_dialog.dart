import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_toolbox/todo/todo_page.dart';

import 'model/todo_Item_model.dart';

class TodoDialogBuilder extends StatelessWidget {
  final VoidCallback onConfirm;
  final TextEditingController dialogTitleController;
  final TextEditingController dialogProgressController;
  final TextEditingController dialogSubTitleController;
  CategoriesModel currentCategory;
  final String confirmText;

  TodoDialogBuilder({super.key, required this.onConfirm, required this.dialogTitleController,required this.currentCategory, required this.dialogProgressController, required this.dialogSubTitleController, this.confirmText = "添加"});

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0), // 去除圆角
      ),
      contentPadding: const EdgeInsets.all(8.0),
      backgroundColor: const Color(0xFFFFFFFF),
      surfaceTintColor: const Color(0xFFFFFFFF),
      title: const Text('添加待办事项'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              titleTextField(),
              const SizedBox(height: 5,),
              Row(children: [
                const Text("类型："),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<CategoriesModel>(
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  value: currentCategory,
                  items: categories.map((
                      CategoriesModel value,) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.categoryName),
                    );
                  }).toList(),
                  onChanged: (CategoriesModel? Category) {
                    currentCategory = Category!;
                  },
                ),
              ]),
              const SizedBox(height: 5,),
              Row(children: [
                const Text("完成进度："),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: dialogProgressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(5),
                      suffixText: "%"
                    ),
                    style: const TextStyle(fontSize: 12),
                    inputFormatters: [
                      RangeInputFormatter(min: 0, max: 100),
                    ],
                  ),
                ),
              ],),
              const SizedBox(height: 5,),
              subTitleTextArea(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if(!(_formKey.currentState as FormState).validate()){
              return;
            }
            onConfirm();
            Navigator.of(context).pop(); // 关闭对话框
          },
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 关闭对话框
          },
          child: const Text(
            '取消',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.zero,
    );
  }

  Row titleTextField() {
    return Row(children: [
      const Text("标题："),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: TextFormField(
          controller: dialogTitleController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              isCollapsed: true,
              contentPadding: EdgeInsets.all(5),),
          style: const TextStyle(fontSize: 12),
          validator: (v){
            if(v == null || v.isEmpty){
              return "标题不能为空";
            }
            return null;
          },
        ),
      ),
    ]);
  }

  Container subTitleTextArea() {
    return Container(
      height: 50,
      constraints: const BoxConstraints(
        maxHeight: 100, // 设置最大高度
      ),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 12),
        cursorWidth: 1,
        expands: true,
        maxLines: null,
        controller: dialogSubTitleController,
        decoration: const InputDecoration(
          labelStyle: TextStyle(fontSize: 12),
          labelText: "描述",
          hintText: "详细描述",
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(),
          isDense: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.all(5),
        ),
      ),
    );
  }
}

class RangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    // 验证输入是否为有效的数字
    if (text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(text);

    // 如果不是数字或不在范围内，则不允许输入
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}
