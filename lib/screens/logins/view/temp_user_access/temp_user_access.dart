import 'package:flutter/material.dart';
import 'package:spa_client_app/const/const.dart';
import 'package:spa_client_app/global/widgets/shadowed_text.dart';

class TempUserAccess extends StatelessWidget {
  const TempUserAccess({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ShadowedText(
              text: 'Scan the QR code provided by the Coach app.',
              fontSize: 20,
              color: mainBlueColor,
              textAling: TextAlign.center,
            ),
            const Placeholder(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('MAMUALY ENTRY'),
            )
          ],
        ),
      ),
    );
  }
}
