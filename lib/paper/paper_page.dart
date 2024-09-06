import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fun_toolbox/paper/paper_app_bar.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperState();
}

class _PaperState extends State<PaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PaperAppBar(onClear: _clear,),
        body: CustomPaint(
          painter: PaperPainter(),
          child: ConstrainedBox(constraints: const BoxConstraints.expand(),),
        ),
    );
  }

  void _clear() {}
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = const [
      Offset(100,100),
      Offset(100,150),
      Offset(150,150),
      Offset(200,100),
    ];

    Paint paint = Paint();
    paint.strokeWidth = 10;
    canvas.drawPoints(PointMode.lines, points , paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
