import 'package:flutter/material.dart';
import 'package:fun_toolbox/guess/result_notice.dart';

import 'guess_app_bar.dart';

class GuessPage extends StatelessWidget {
  const GuessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GuessAppBar(),
      body: const Stack(children: [
        Column(
          children: [
            Expanded(
              child: ResultNotice(color: Colors.red, info: "大了",),
            ),
            Expanded(
              child: ResultNotice(color: Colors.blue, info: "小了",),
            ),
          ],
        ),
        Center(
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
