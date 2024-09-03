import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:fun_toolbox/muyu/muyu_animate_text.dart';
import 'package:fun_toolbox/muyu/muyu_image.dart';

import 'muyu_app_bar.dart';
import 'muyu_count_panel.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  int _counter = 0;
  int _cruValue = 0;

  final List<int> _muyuAnimateTextCache = [];

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MuyuAppBar(
        tapHistory: _toHistory,
      ),
      body: Column(
        children: [
          Expanded(
              child: MuyuCountPanel(
            count: _counter,
            onTapSwitchImage: () {},
            onTapSwitchAudio: () {},
          )),
          Expanded(
              child: Stack(alignment: Alignment.topCenter, children: [
            MuyuImage(
              image: "assets/images/muyu1.png",
              onTap: _onKnock,
            ),
            if (_cruValue != 0)
              ...List.generate(_muyuAnimateTextCache.length, (index) => MuyuAnimateText(text: '功德+${_muyuAnimateTextCache[index]}',)),
          ])),
        ],
      ),
    );
  }

  void _toHistory() {}

  void _onKnock() async {
    // 随机增加1-3个数
    int addCount = _random.nextInt(3) + 1;
    _cruValue = addCount;
    _muyuAnimateTextCache.add(_cruValue);
    _counter += addCount;

    // 清除多余的元素
    if(_muyuAnimateTextCache.length > 30) {
      _muyuAnimateTextCache.clear();
      _muyuAnimateTextCache.add(_cruValue);
    }
    setState(() {});
    FlameAudio.play('muyu_3.mp3');
  }
}
