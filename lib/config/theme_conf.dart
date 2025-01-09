import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/const.dart';

class MainThemeConf {
  static theme(context) => ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        brightness: Brightness.light,
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackColor: WidgetStateProperty.all(mainBlueColor),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: mainBlueColor,
            iconColor: mainBlueColor,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.transparent,
          selectedTileColor: mainBlueColor,
          iconColor: mainBlueColor,
        ),
        // iconTheme: const IconThemeData(color: Colors.black),
        // iconButtonTheme: IconButtonThemeData(
        //   style: ButtonStyle(
        //     foregroundColor: WidgetStateProperty.all(mainBlueColor),
        //   ),
        // ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: mainBlueColor, foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlueColor,
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}
