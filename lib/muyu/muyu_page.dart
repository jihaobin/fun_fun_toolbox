import 'package:flutter/material.dart';
import 'package:fun_toolbox/muyu/muyu_image.dart';

import 'muyu_app_bar.dart';
import 'muyu_count_panel.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MuyuAppBar(tapHistory: _toHistory,),
      body: Column(
        children: [
          Expanded(child: MuyuCountPanel(count: 0, onTapSwitchImage: () {}, onTapSwitchAudio: () {},)),
          const Expanded(child: MuyuImage(image: "asserts/images/muyu1.png",)),
        ],
      ),
    );
  }

  void _toHistory() {}

}

