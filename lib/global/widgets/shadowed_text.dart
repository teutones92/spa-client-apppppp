import 'package:flutter/material.dart';

class ShadowedText extends StatelessWidget {
  const ShadowedText(
      {super.key, required this.text, this.fontSize, this.color});
  final String text;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
        shadows: const [
          Shadow(
            color: Colors.grey,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
