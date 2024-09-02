import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget{
  const ResultNotice({super.key, required this.color, required this.info});

  final Color color;
  final String info;

  @override
  State<ResultNotice> createState() => _ResultNoticeState();
}

class _ResultNoticeState extends State<ResultNotice>  with TickerProviderStateMixin  {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


@override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.color,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Text(
            widget.info,
            style: TextStyle(
                fontSize: 54 * (_controller.value),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
        }
      ),
    );
  }
}
