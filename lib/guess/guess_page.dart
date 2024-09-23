import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_toolbox/guess/result_notice.dart';

import 'guess_app_bar.dart';

class GuessPage extends StatefulWidget{
  const GuessPage({super.key});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  final TextEditingController _guessTextEditingController = TextEditingController();

  int _randomValue = 0;
  bool _guessing = false;

  bool? _isBig;

  late  AnimationController animatedController;
  
  @override
  initState(){
    animatedController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500),);
    super.initState();
  }

  _generateRandomValue(){
    _guessing = true;
    // 生成一个0-100的随机数
    _randomValue = Random().nextInt(101);
    setState(() {});
  }

  _onCheckGuessValue(){
    print("=====Check:目标数值:$_randomValue=====${_guessTextEditingController.text}============");
    int? guessValue = int.tryParse(_guessTextEditingController.text);

    // 如果游戏没有开始，或者输入的不是整数那么直接无视
    if(!_guessing || guessValue == null) return;
    // 启动动画
    animatedController.forward(from: 0);

    // 如果猜对了，那么游戏结束
    if(guessValue == _randomValue){
      _guessing = false;
      _isBig = null;
      setState(() {});
    }else{
      // 如果猜错了，那么判断猜的大还是小
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
              // 这里的不能将ResultNotice组件声明为const组件，否则不会触发ResultNotice中didUpdateWidget声明周期方法
              Expanded(
              child: ResultNotice(color: Colors.red, info: "大了", controller: animatedController),
            ),
            const Spacer(),
            if(!_isBig!)
              Expanded(
              child: ResultNotice(color: Colors.blue, info: "小了", controller: animatedController,),
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

  @override
  bool get wantKeepAlive => true;
}
