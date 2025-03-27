import 'package:events_jo/config/theme/themes/app_icon_button_theme.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

ThemeData eventsJoTheme() {
  return ThemeData(
      fontFamily: 'Abel',
      scaffoldBackgroundColor: GColors.scaffoldBg,
      appBarTheme: AppBarTheme(
        backgroundColor: GColors.appBarBg,
      ),
      iconButtonTheme: appIconButtonTheme(),
      iconTheme: appIconTheme(),
      textButtonTheme: appTextButtonTheme(),
      dividerTheme: DividerThemeData(
        color: GColors.black,
        // width: 0,
        thickness: 0.2,
        indent: 10,
        endIndent: 10,
      ));
}

TextButtonThemeData appTextButtonTheme() {
  return TextButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(GColors.white),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kOuterRadius),
      ),
    ),
  ));
}

IconThemeData appIconTheme() {
  return IconThemeData(
    size: 20,
    color: GColors.black,
  );
}
