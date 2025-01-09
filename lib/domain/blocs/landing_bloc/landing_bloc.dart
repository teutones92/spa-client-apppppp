import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';

class LandingBloc extends Cubit<int> {
  LandingBloc() : super(0);

  PageController pageController = PageController();

  void swapPage(int index) {
    pageController.jumpToPage(index);
    emit(index);
  }

  void resetState() => emit(0);
}
