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
    return Scaffold(
      body: BackGroundImage(
        opacity: 1,
        path: "assets/images/bg_ads.png",
        children: [
          // Center(
          //   child: Container(
          //     width: size.width,
          //     height: 1,
          //     color: Colors.white,
          //   ),
          // ),
          // Center(
          //   child: Container(
          //     height: size.height,
          //     width: 1,
          //     color: Colors.white,
          //   ),
          // ),
          BlocBuilder<PublicityBloc, PublicityBlocState>(
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  key: ValueKey('loading'),
                                )
                              : state.promoModelsList.isEmpty
                                  ? const Padding(
                                      key: ValueKey('empty'),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "The manager hasn't added any publicity yet. Please check back later!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const PublicityButtons(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const PublicityBottomButtons()
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
