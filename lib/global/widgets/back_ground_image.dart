import 'package:flutter/material.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage(
      {super.key,
      required this.path,
      required this.children,
      this.opacity = 0.2});

  final String path;
  final List<Widget> children;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: opacity,
          child: Image.asset(
            path,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        ...children,
      ],
    );
  }
}
