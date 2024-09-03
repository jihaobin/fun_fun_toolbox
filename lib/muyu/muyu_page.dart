import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_toolbox/muyu/models/audio_model.dart';
import 'package:fun_toolbox/muyu/muyu_animate_text.dart';
import 'package:fun_toolbox/muyu/muyu_image.dart';

import 'models/muyu_model.dart';
import 'muyu_app_bar.dart';
import 'muyu_count_panel.dart';
import 'options/muyu_audio_option.dart';
import 'options/muyu_type_option.dart';

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

  final List<MuyuModel> muyuTypeOptions = const [
    MuyuModel(name: '基础版',src: 'assets/images/muyu1.png',min: 1,max: 3),
    MuyuModel(name: '尊享版',src: 'assets/images/muyu2.png',min: 3,max: 6),
  ];
  int _activeMuyuIndex = 0;


  final List<AudioModel> audioTypeOptions = const [
    AudioModel(name: '音效1', src: 'muyu_1.mp3'),
    AudioModel(name: '音效2', src: 'muyu_2.mp3'),
    AudioModel(name: '音效3', src: 'muyu_3.mp3'),
  ];
  int _activeAudioIndex = 0;

  late AudioPool pool;

  @override
  void initState() {
    super.initState();
    initAudioPool();
  }

  void initAudioPool() async{
    // 初始化音频池
    pool = await FlameAudio.createPool(activeAudio,maxPlayers: 10);
  }


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
              onTapSwitchMuyu: _onTapSwitchIMuyu,
              onTapSwitchAudio: _onTapSwitchAudio,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuImage(
                  image: activeMuyuImage,
                  onTap: _onKnock,
                ),
                if (_cruValue != 0)
                  ...List.generate(
                    _muyuAnimateTextCache.length,
                    (index) => MuyuAnimateText(
                      text: '功德+${_muyuAnimateTextCache[index]}',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toHistory() {}

  int get knockCount {
    int min = muyuTypeOptions[_activeMuyuIndex].min;
    int max = muyuTypeOptions[_activeMuyuIndex].max;

    return _random.nextInt(max - min + 1) + min;
  }

  void _onKnock() async {
    // 随机增加1-3个数
    _cruValue = knockCount;
    _counter += knockCount;
    _muyuAnimateTextCache.add(_cruValue);

    // 清除多余的元素
    if (_muyuAnimateTextCache.length > 30) {
      _muyuAnimateTextCache.removeLast();
      _muyuAnimateTextCache.add(_cruValue);
    }
    setState(() {});
    pool.start();
  }

  String get activeMuyuImage{
    return muyuTypeOptions[_activeMuyuIndex].src;
  }

  void _onSelectMuyu(int selectIndex){
    // 每次选择木鱼类型时候
    Navigator.of(context).pop();

    // 如果选择的类型和上一次一样，则不更新页面
    if(_activeMuyuIndex == selectIndex)return;
    _activeMuyuIndex = selectIndex;
    setState(() {});
  }

  void _onTapSwitchIMuyu(){
    showCupertinoModalPopup(context: context, builder: (BuildContext context){
      return MuyuOptionPanel(imageOptions: muyuTypeOptions,activeIndex: _activeMuyuIndex,onSelect: _onSelectMuyu);
    });
  }

  String get activeAudio{
    return audioTypeOptions[_activeAudioIndex].src;
  }

  void _onSelectAudio(int selectIndex) async{
    Navigator.of(context).pop();
    if(_activeAudioIndex == selectIndex)return;
    _activeAudioIndex = selectIndex;
    FlameAudio.play(activeAudio);
    setState(() {});

    // 更新音频池里的音频
    pool = await FlameAudio.createPool(
      activeAudio,
      maxPlayers: 10,
    );
  }

  void _onTapSwitchAudio(){
    showCupertinoModalPopup(context: context, builder: (BuildContext context){
      return AudioOptionPanel(audioOptions: audioTypeOptions,activeIndex: _activeAudioIndex,onSelect: _onSelectAudio);
    });
  }
}
