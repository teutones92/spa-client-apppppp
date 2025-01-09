import 'package:flutter/material.dart';

class GlobalSnack {
  static void show(
      {required BuildContext context, required String message, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message, textAlign: TextAlign.center),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
