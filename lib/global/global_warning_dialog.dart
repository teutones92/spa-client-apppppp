import 'package:flutter/material.dart';

class GlobalWarningDialog extends StatelessWidget {
  const GlobalWarningDialog(
      {super.key,
      this.title = 'Warning!',
      required this.content,
      required this.callback});

  final String title;
  final String content;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            callback!();
          },
          child: const Text('Agree'),
        ),
      ],
    );
  }
}
