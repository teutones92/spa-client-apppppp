import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bloc = context.read<LoginBloc>();
      return Column(
        children: List.generate(bloc.controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BlocBuilder<LoginBloc, LoginBlocState>(
              builder: (__, state) {
                return TextField(
                  obscureText: index == 1 ? state.obscurePassword : false,
                  keyboardType: index == 0
                      ? TextInputType.emailAddress
                      : TextInputType.visiblePassword,
                  controller: context.read<LoginBloc>().controllers[index],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(58, 197, 197, 197),
                    label: Text(index == 0 ? 'Email' : 'Password'),
                    // hintStyle: const TextStyle(
                    //   color: Color.fromARGB(255, 33, 51, 243),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(0, 33, 51, 243),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 33, 51, 243),
                      ),
                    ),
                    suffixIcon: index == 1
                        ? IconButton(
                            onPressed: () => bloc.swapPasswordVisivility(),
                            icon: Icon(
                              state.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 33, 51, 243),
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          );
        }),
      );
    });
  }
}
