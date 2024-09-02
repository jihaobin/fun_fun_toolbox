import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget{
  const GuessAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF3F6F9),
            constraints: BoxConstraints(maxHeight: 35),
            border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(6))),
            hintText: "请输入0~100的数字",
            hintStyle: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.run_circle_outlined,
                color: Colors.blue,
              ))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
