import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/global/widgets/back_ground_image.dart';
import 'package:spa_client_app/global/widgets/shadowed_text.dart';

import 'widgets/publicity_bottom_buttons.dart';
import 'widgets/publicity_buttons.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    context.read<PublicityBloc>().getPublicity();
  }

  @override
  Widget build(BuildContext context) {
    const boxSize = 400.0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackGroundImage(
        opacity: 1,
        path: "assets/images/bg_ads.png",
        children: [
          Positioned.fill(
            child: BlocBuilder<PublicityBloc, PublicityBlocState>(
              builder: (context, state) {
                return ListView(
                  physics: size.height > 800
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShadowedText(
                            text: 'Welcome!',
                            fontSize: 50,
                            color: Colors.white),
                        ShadowedText(
                          text: 'This is what we do best!',
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: state.isLoading
                          ? const CircularProgressIndicator(
                              key: ValueKey('loading'),
                            )
                          : state.promoModelsList.isEmpty
                              ? const Padding(
                                  key: ValueKey('empty'),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "The manager hasn't added any publicity yet. Please check back later!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  key: const ValueKey('loaded'),
                                  width: boxSize,
                                  height: size.height / 2,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          width: boxSize,
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const PublicityButtons(),
                                    ],
                                  ),
                                ),
                    ),
                    const SizedBox(height: 20),
                    const PublicityBottomButtons()
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
