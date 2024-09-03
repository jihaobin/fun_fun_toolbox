import 'package:flutter/material.dart';

class MuyuImage extends StatelessWidget {
  const MuyuImage({
    super.key, required this.image, required this.onTap,
  });

  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
          child: Image.asset(
            image,
            height: 200,
          )),
    );
  }
}