import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData get mainTheme {
    //1
    return ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: const ContinuousRectangleBorder(),
            )
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: MyColors.textColor,
              fontSize: 50,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.normal),
          bodySmall: TextStyle(
              color: MyColors.historyTextColor,
              fontSize: 45,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.normal,
          )
        )
    );
  }
}