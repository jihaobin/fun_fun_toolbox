import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_toolbox/guess/result_notice.dart';

import 'guess_app_bar.dart';

class GuessPage extends StatefulWidget{
  const GuessPage({super.key});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  final TextEditingController _guessTextEditingController = TextEditingController();

  int _randomValue = 0;
  bool _guessing = false;

  bool? _isBig;

  _generateRandomValue(){
    _guessing = true;
    _randomValue = Random().nextInt(100);
    setState(() {});
  }

  _onCheckGuessValue(){
    print("=====Check:目标数值:$_randomValue=====${_guessTextEditingController.text}============");
    int? guessValue = int.tryParse(_guessTextEditingController.text);

    // 如果游戏没有开始，或者输入的不是整数那么直接无视
    if(!_guessing || guessValue == null) return;

    if(guessValue == _randomValue){
      _guessing = false;
      _isBig = null;
      setState(() {});
    }else{
      _isBig = guessValue > _randomValue;
      _guessTextEditingController.clear();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _guessTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(textFieldController: _guessTextEditingController, onCheckGuessValue: _onCheckGuessValue,),
      body:  Stack(children: [
        if(_isBig != null)
        Column(
          children: [
            if(_isBig!)
            const Expanded(
              child: ResultNotice(color: Colors.red, info: "大了",),
            ),
            const Spacer(),
            if(!_isBig!)
            const Expanded(
              child: ResultNotice(color: Colors.blue, info: "小了",),
            ),
          ],
        ),
         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(!_guessing)
              const Text(
                "请点击生成随机的数字",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                _guessing ? "***": "$_randomValue",
                style: const TextStyle(fontSize: 46,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.greenAccent,
        tooltip: '生成随机数',
        child: Icon(Icons.generating_tokens_outlined,color: Colors.greenAccent.shade700,),
      ),
    );
  }
}
