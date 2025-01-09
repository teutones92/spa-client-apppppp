import 'package:flutter/material.dart';
import 'package:spa_client_app/screens/logins/view/online_user_login/widgets/forgot_password_button.dart';
import 'package:spa_client_app/screens/logins/view/online_user_login/widgets/login_text_filed.dart';

import 'widgets/logo_image_widget.dart';
import 'widgets/top_title_widget.dart';

class OnlineUserLogin extends StatelessWidget {
  const OnlineUserLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: const [
              SizedBox(height: 80),
              LogoImageWidget(),
              SizedBox(height: 40),
              TopTitleWidget(),
              SizedBox(height: 40),
              LoginTextField(),
              ForgotPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}
