import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget{
  const ResultNotice({super.key, required this.color, required this.info, required this.controller});

  final Color color;
  final String info;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Text(
            info,
            style: TextStyle(
                fontSize: 54 * (controller.value),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
        }
      ),
    );
  }
}
