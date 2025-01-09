import 'package:flutter/material.dart';

import '../../../../../config/bloc_config.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.read<LoginBloc>().forgotPassword(context),
        child: const Text(
          'Forgot Password?',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color.fromARGB(255, 33, 51, 243),
          ),
        ),
      ),
    );
  }
}
