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
    Paint paint = Paint();
    paint.color = Colors.black;
    // 设置绘图的风格，填充/边框
    paint.style = PaintingStyle.fill;
    // 设置画笔大小
    paint.strokeWidth = 5;
    // 设置线条末端的样式
    paint.strokeCap = StrokeCap.round;
    // 设置线条链接处的样式
    paint.strokeJoin = StrokeJoin.round;
    // 设置是否启用抗锯齿
    paint.isAntiAlias = true;

    // 绘制圆形
    // canvas.drawCircle(const Offset(100, 100), 50, paint);
    // paint.style = PaintingStyle.stroke;
    // canvas.drawCircle(const Offset(250, 100), 50, paint);

    // // 绘制矩形
    // var rect = Rect.fromCenter(center: const Offset(100,100), width: 100,height: 100);
    // canvas.drawRect(rect, paint);
    // // 绘制圆角矩形
    // paint.style = PaintingStyle.stroke;
    // var rect2 = Rect.fromCenter(center: const Offset(250,100), width: 100,height: 100);
    // var rrect = RRect.fromRectXY(rect2, 8,8);
    // canvas.drawRRect(rrect, paint);

    // 绘制文本

    // // 定义文字的内容以及样式
    // const textSpan = TextSpan(
    //   text: 'Hello, Flutter!',
    //   style: TextStyle(
    //     color: Colors.red,
    //     fontSize: 24,
    //     fontWeight: FontWeight.bold,
    //   ),
    // );
    //
    // // 定义文字的显示格式，对齐当时,显示方向
    // final textPainter = TextPainter(
    //   text: textSpan,
    //   textAlign: TextAlign.center,
    //   textDirection: TextDirection.ltr,
    // );
    //
    // // 计算文字的宽高
    // textPainter.layout(
    //   minWidth: 0,
    //   maxWidth: size.width,
    // );
    //
    // final offset = Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2);
    // textPainter.paint(canvas, offset);

    // // 绘制椭圆
    // var overRect = Rect.fromCenter(center: const Offset(100,100), width: 100,height: 50);
    // canvas.drawOval(overRect, paint);
    //
    // // 绘制圆弧
    // paint.style = PaintingStyle.stroke;
    // overRect = Rect.fromCenter(center: const Offset(100,100), width: 100,height: 100);
    // canvas.drawArc(overRect.translate(150, 0), 0, (pi  * 2) * 0.7,false,paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
