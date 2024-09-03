import 'package:flutter/material.dart';

class MuyuImage extends StatelessWidget {
  const MuyuImage({
    super.key, required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
          image,
          height: 200,
        ));
  }
}