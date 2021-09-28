import 'package:flutter/material.dart';

class ThemeColors {
  static const Color primaryColor = Color.fromRGBO(17, 0, 102, 1);
  static const Color indicatorColor = Color.fromRGBO(255, 212, 50, 1);
  static const Color backgroundColor = Colors.white;

  static const IconThemeData iconTheme = IconThemeData(
    opacity: 1,
    color: Colors.white,
  );

  static final ColorScheme colorScheme = ThemeData.light().colorScheme.copyWith(
        primary: const Color.fromRGBO(6, 46, 115, 1),
        primaryVariant: const Color.fromRGBO(144, 203, 251, 1),
        onPrimary: Colors.white,
        secondary: const Color.fromRGBO(255, 212, 50, 1),
        secondaryVariant: const Color.fromRGBO(189, 101, 45, 1),
        onSecondary: primaryColor,
        background: Colors.white,
        onBackground: Colors.black,
      );
}
