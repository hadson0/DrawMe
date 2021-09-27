import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromRGBO(43, 56, 140, 1);
  static const Color indicatorColor = Color.fromRGBO(214, 195, 51, 1);
  static const Color backgroundColor = Colors.white;

  static const IconThemeData iconTheme = IconThemeData(
    opacity: 1,
    color: Colors.white,
  );

  static final ColorScheme colorScheme = ThemeData.light().colorScheme.copyWith(
        primary: const Color.fromRGBO(29, 74, 138, 1),
        primaryVariant: const Color.fromRGBO(10, 193, 199, 1),
        secondary: const Color.fromRGBO(214, 195, 51, 1),
        secondaryVariant: const Color.fromRGBO(189, 101, 45, 1),
      );
}
