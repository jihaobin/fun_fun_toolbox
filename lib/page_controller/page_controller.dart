import 'package:flutter/material.dart';
import 'package:fun_toolbox/page_controller/page_bottom_bar.dart';
import 'package:fun_toolbox/paper/paper_page.dart';

import '../guess/guess_page.dart';
import '../muyu/muyu_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;

  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(_index),
      bottomNavigationBar: AppBottomBar(menus: menus,currentIndex: _index,onItemTap: _onChangePage,),
    );
  }

  void _onChangePage(int index) {
    setState(() {
      _index = index;
    });
  }
  Widget _buildContent(int index) {
    switch(index){
      case 0:
        return const GuessPage();
      case 1:
        return const MuyuPage();
      case 2:
        return const PaperPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
