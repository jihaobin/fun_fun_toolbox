import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessPage extends StatelessWidget {
  const GuessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          ]),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: const Text(
                  "大了",
                  style: TextStyle(
                      fontSize: 54,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                child: const Text(
                  "小了",
                  style: TextStyle(
                      fontSize: 54,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "请点击生成随机的数字",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "0",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.greenAccent,
        tooltip: '生成随机数',

        child: Icon(Icons.generating_tokens_outlined,color: Colors.greenAccent.shade700,),
      ),
    );
  }
}
