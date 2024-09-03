import 'dart:math';

import 'package:flutter/material.dart';

class MuyuAnimateText extends StatefulWidget {
  const MuyuAnimateText({super.key, required this.text});

  final String text;

  @override
  State<MuyuAnimateText> createState() => _MuyuAnimateTextState();
}

class _MuyuAnimateTextState extends State<MuyuAnimateText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);
    _scale = Tween<double>(begin: 1, end: 0.8).animate(_controller);

    // 随机生成x轴的偏移
    var positionX = Random().nextInt(5) - 2;
    _position = Tween<Offset>(
            begin: Offset(positionX.toDouble(), 3),
            end: Offset(positionX.toDouble(), 0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MuyuAnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: SlideTransition(
        position: _position,
        child: FadeTransition(
          opacity: _opacity,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
