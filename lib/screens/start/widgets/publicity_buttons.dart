import 'package:flutter/material.dart';

import '../../../../../../config/bloc_config.dart';

class PublicityButtons extends StatelessWidget {
  const PublicityButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bloc = context.read<PublicityBloc>();
      return BlocBuilder<PublicityBloc, PublicityBlocState>(
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: state.promoModelsList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            semanticChildCount: 2,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = state.promoModelsList[index];
              return Card(
                elevation: 0,
                color: const Color.fromARGB(88, 140, 140, 140),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => bloc.openPublicity(context, item),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: !item.iconImage.contains('https')
                            ? Image.asset(
                                'assets/images/loading.gif',
                                height: 90,
                                width: 90,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: item.iconImage,
                                height: 90,
                                width: 90,
                              ),
                      ),
                      const Spacer(),
                      Text(
                        item.title.text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
