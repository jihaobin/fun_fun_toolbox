import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fun_toolbox/paper/paper_app_bar.dart';
import 'package:fun_toolbox/paper/paper_color_selector.dart';
import 'package:fun_toolbox/paper/paper_comform_dialog.dart';
import 'package:fun_toolbox/paper/paper_stock_width_selector.dart';

import 'model/line.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperState();
}

class _PaperState extends State<PaperPage> {
  final List<Line> _lines = []; // 线列表

  final _historyLines = []; // 历史线列表

  int _activeColorIndex = 0; // 颜色激活索引
  int _activeStorkWidthIndex = 0; // 线宽激活索引

// 支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.grey,
    Colors.brown,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink
  ];

// 支持的线粗
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _clear,
        onBack: _lines.isEmpty || _historyLines.length >=20 ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanStart: _onPanStart,
        child: Stack(
          children: [
            CustomPaint(
              painter: PaperPainter(_lines),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: Row(
                children: [
                  Expanded(
                    child: ColorSelector(supportColors: supportColors, activeIndex: _activeColorIndex, onSelect: (int value) {
                      _activeColorIndex = value;
                      setState(() {});
                    },),
                  ),
                  StockWidthSelector(
                      supportStorkWidths: supportStorkWidths,
                      onSelect: (int index) {
                        _activeStorkWidthIndex = index;
                        setState(() {});
                      },
                      activeIndex: _activeStorkWidthIndex,
                      color: supportColors[_activeColorIndex]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _clear() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PaperConformDialog(
            title: '清空提示',
            msg: '您的当前操作会清空绘制内容，是否确定删除!',
            onConform: () {
              _lines.clear();
              setState(() {});
              Navigator.pop(context);
            },
          );
        });
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(
      Line(
        points: [details.localPosition],
        strokeWidth: supportStorkWidths[_activeStorkWidthIndex],
        color: supportColors[_activeColorIndex],
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _lines.last.points.add(details.localPosition);
    });
    setState(() {});
  }
  
  void _back(){
    Line line = _lines.removeLast();
    _historyLines.add(line);
    setState(() {});
  }

  void _revocation(){
    Line line = _historyLines.removeLast();
    _lines.add(line);
    setState(() {});
  }

}

class PaperPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  PaperPainter(this.lines);
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      drawLine(canvas, line);
    }
  }

  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
