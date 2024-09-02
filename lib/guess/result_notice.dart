import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  const ResultNotice({super.key, required this.color, required this.info});

  final Color color;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        info,
        style:const TextStyle(
            fontSize: 54,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
