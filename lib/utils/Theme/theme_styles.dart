import 'package:drawme/utils/Theme/theme_colors.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static final textTheme = ThemeData.light().textTheme.copyWith(
        headline6: ThemeData.light().textTheme.headline6?.copyWith(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
        headline5: ThemeData.light().textTheme.headline5?.copyWith(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
        headline1: ThemeData.light().textTheme.headline1?.copyWith(
              fontFamily: 'Pacifico',
              fontSize: 28,
            ),
        bodyText2: ThemeData.light().textTheme.bodyText2?.copyWith(
              fontFamily: 'Nunito',
              fontSize: 16,
            ),
        bodyText1: ThemeData.light().textTheme.bodyText1?.copyWith(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
      );
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: ThemeColors.colorScheme.primary,
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      textStyle: textTheme.headline5?.copyWith(
        fontSize: 15,
      ),
    ),
  );
}
