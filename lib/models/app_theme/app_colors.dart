import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromRGBO(24, 35, 73, 1);
  static const Color primaryColorDark = Color.fromRGBO(0, 0, 47, 1);
  static const Color primaryColorLight = Color.fromRGBO(2, 62, 115, 1);
  static const Color indicatorColor = Color.fromRGBO(5, 158, 179, 1);
  static const Color darkBackgroundColor = Color.fromRGBO(17, 25, 52, 1);

  static final ColorScheme darkColorScheme =
      ThemeData.dark().colorScheme.copyWith(
            primary: const Color.fromRGBO(24, 35, 73, 1),
            secondary: const Color.fromRGBO(0, 187, 212, 1),
          );
}
