import 'package:flutter/material.dart';
import 'package:spa_client_app/const/const.dart';
import 'package:spa_client_app/global/widgets/shadowed_text.dart';

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShadowedText(
          text: 'Sierra Pitching Academy',
          color: mainBlueColor,
          fontSize: 30,
          textAling: TextAlign.center,
        ),
        SizedBox(height: 10),
        ShadowedText(
          text: 'Online',
          color: mainBlueColor,
          fontSize: 30,
          textAling: TextAlign.center,
        ),
      ],
    );
  }
}
