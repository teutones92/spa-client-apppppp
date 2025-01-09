import 'package:flutter/material.dart';

class GlobalLoadingDialog {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void show(BuildContext context, {String message = ''}) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      );

  static void hide(BuildContext? context) =>
      Navigator.of(context ?? scaffoldKey.currentContext!).pop();
}
