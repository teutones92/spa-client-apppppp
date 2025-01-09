import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_client_app/domain/blocs/publicity_bloc/publicity_bloc.dart';
import 'package:spa_client_app/global/widgets/global_delete_button.dart';
import 'package:spa_client_app/models/apps/publicity_button_model/publicity_button_model.dart';

class PublicityBottomButtons extends StatelessWidget {
  const PublicityBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicityBloc, PublicityBlocState>(
      builder: (context, state) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: EdgeInsets.symmetric(
                  vertical: 20, horizontal: state.swapButtons ? 20 : 0),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: state.swapButtons
                    ? const Color.fromARGB(131, 158, 158, 158)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey(state.swapButtons),
                  children: List.generate(
                    state.swapButtons
                        ? PublicityBottomButtonModel.list1.length
                        : PublicityBottomButtonModel.list2.length,
                    (index) {
                      final item = state.swapButtons
                          ? PublicityBottomButtonModel.list1[index]
                          : PublicityBottomButtonModel.list2[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == 0 ? 20 : 0),
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<PublicityBloc>()
                              .actions(item, context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(131, 158, 158, 158),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              child: AnimatedSlide(
                offset: Offset(state.swapButtons ? 0 : 2, 0),
                duration: const Duration(milliseconds: 300),
                child: GlobalIconButton(
                  key: const ValueKey('close'),
                  iconColor: Colors.black,
                  iconData: Icons.arrow_back,
                  onTap: () => context.read<PublicityBloc>().swapButtons(false),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
