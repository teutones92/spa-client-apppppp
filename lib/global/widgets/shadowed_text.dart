import 'package:flutter/material.dart';

class ShadowedText extends StatelessWidget {
  const ShadowedText(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.textAling});
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAling;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAling,
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
