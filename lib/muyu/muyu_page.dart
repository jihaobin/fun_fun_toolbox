import 'dart:async';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_toolbox/muyu/models/audio_model.dart';
import 'package:fun_toolbox/muyu/muyu_animate_text.dart';
import 'package:fun_toolbox/muyu/muyu_image.dart';
import 'package:uuid/uuid.dart';

import 'models/history_record_model.dart';
import 'models/muyu_model.dart';
import 'muyu_app_bar.dart';
import 'muyu_count_panel.dart';
import 'muyu_history_record.dart';
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
    MuyuModel(name: '基础版', src: 'assets/images/muyu1.png', min: 1, max: 3),
    MuyuModel(name: '尊享版', src: 'assets/images/muyu2.png', min: 3, max: 6),
  ];
  int _activeMuyuIndex = 0;

  final List<AudioModel> audioTypeOptions = const [
    AudioModel(name: '音效1', src: 'muyu_1.mp3'),
    AudioModel(name: '音效2', src: 'muyu_2.mp3'),
    AudioModel(name: '音效3', src: 'muyu_3.mp3'),
  ];
  int _activeAudioIndex = 0;

  late AudioPool pool;
  final Uuid uuid = const Uuid();

  List<HistoryRecordModel> historyRecord = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initAudioPool();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void initAudioPool() async {
    // 初始化音频池
    pool = await FlameAudio.createPool(activeAudio, maxPlayers: 10);
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

  void _toHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            MuyuRecordModel(records: historyRecord.reversed.toList()),
      ),
    );
  }

  void resetTimer() {
    // 如果已有定时器，取消它
    _timer?.cancel();

    // 创建一个新的定时器
    _timer = Timer(const Duration(seconds: 2), () {
      // 定时器结束后清空列表
      setState(() {
        _muyuAnimateTextCache.clear();
      });
    });
  }
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
    resetTimer();

    // 存储历史纪录
    String id = uuid.v4();
    historyRecord.add(
      HistoryRecordModel(
        id: id,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        value: _cruValue,
        image: activeMuyuImage,
        audio: audioTypeOptions[_activeAudioIndex].name,
      ),
    );
    // 最多保存100条记录
    if(historyRecord.length > 100){
      historyRecord.removeAt(0);
    }

    setState(() {});
    pool.start();
  }

  String get activeMuyuImage {
    return muyuTypeOptions[_activeMuyuIndex].src;
  }

  void _onSelectMuyu(int selectIndex) {
    // 每次选择木鱼类型时候
    Navigator.of(context).pop();

    // 如果选择的类型和上一次一样，则不更新页面
    if (_activeMuyuIndex == selectIndex) return;
    _activeMuyuIndex = selectIndex;
    setState(() {});
  }

  void _onTapSwitchIMuyu() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return MuyuOptionPanel(
              imageOptions: muyuTypeOptions,
              activeIndex: _activeMuyuIndex,
              onSelect: _onSelectMuyu);
        });
  }

  String get activeAudio {
    return audioTypeOptions[_activeAudioIndex].src;
  }

  void _onSelectAudio(int selectIndex) async {
    Navigator.of(context).pop();
    if (_activeAudioIndex == selectIndex) return;
    _activeAudioIndex = selectIndex;
    FlameAudio.play(activeAudio);
    setState(() {});

    // 更新音频池里的音频
    pool = await FlameAudio.createPool(
      activeAudio,
      maxPlayers: 10,
    );
  }

  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return AudioOptionPanel(
              audioOptions: audioTypeOptions,
              activeIndex: _activeAudioIndex,
              onSelect: _onSelectAudio);
        });
  }
}
