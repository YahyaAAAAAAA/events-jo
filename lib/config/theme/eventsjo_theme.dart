import 'package:events_jo/config/extensions/color_extensions.dart';
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
    dividerTheme: appDividerTheme(),
    inputDecorationTheme: appTextFieldTheme(),
    switchTheme: appSwitchTheme(),
    dialogTheme: appDialogTheme(),
    sliderTheme: appSliderTheme(),
    pageTransitionsTheme: appPageTransitionsTheme(),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      // year2023: false,
      borderRadius: BorderRadius.circular(kOuterRadius),
      color: GColors.royalBlue,
      stopIndicatorColor: GColors.royalBlue,
      circularTrackColor: GColors.whiteShade3.shade600,
      linearTrackColor: GColors.whiteShade3.shade600,
      linearMinHeight: 7,
    ),
  );
}

PageTransitionsTheme appPageTransitionsTheme() {
  return PageTransitionsTheme(
    builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
      TargetPlatform.values,
      value: (_) => const FadeForwardsPageTransitionsBuilder(),
    ),
  );
}

SliderThemeData appSliderTheme() {
  return SliderThemeData(
    trackHeight: 7,
    //ignore: deprecated_member_use
    year2023: false,
    thumbSize: const WidgetStatePropertyAll(Size(3, 25)),
    allowedInteraction: SliderInteraction.tapAndSlide,
    thumbColor: GColors.royalBlue,
    activeTrackColor: GColors.royalBlue,
    inactiveTrackColor: GColors.poloBlue,
    valueIndicatorColor: GColors.royalBlue,
    valueIndicatorTextStyle: TextStyle(
      color: GColors.white,
      fontSize: kSmallFontSize,
      fontFamily: 'Abel',
    ),
  );
}

DialogThemeData appDialogTheme() {
  return DialogThemeData(
    backgroundColor: GColors.whiteShade3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kOuterRadius),
    ),
    titleTextStyle: TextStyle(
      color: GColors.black,
      fontSize: kNormalFontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Abel',
    ),
    contentTextStyle: TextStyle(
      color: GColors.black,
      fontSize: kSmallFontSize,
      fontWeight: FontWeight.normal,
      fontFamily: 'Abel',
    ),
  );
}

SwitchThemeData appSwitchTheme() {
  return SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(GColors.black),
    trackColor: WidgetStatePropertyAll(GColors.whiteShade3),
    trackOutlineWidth: const WidgetStatePropertyAll(0.5),
    trackOutlineColor: WidgetStatePropertyAll(GColors.black),
    padding: const EdgeInsets.all(0),
  );
}

InputDecorationTheme appTextFieldTheme() {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      color: GColors.black,
      fontSize: kSmallFontSize,
    ),
    labelStyle: TextStyle(
      color: GColors.black,
      fontSize: kSmallFontSize,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kOuterRadius),
      borderSide: BorderSide(
        width: 2,
        color: GColors.black.withValues(alpha: 0.5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kOuterRadius),
      borderSide: BorderSide(
        width: 0.2,
        color: GColors.black.withValues(alpha: 0.5),
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kOuterRadius),
      borderSide: BorderSide(
        width: 0.2,
        color: GColors.black.withValues(alpha: 0.5),
      ),
    ),
  );
}

DividerThemeData appDividerTheme() {
  return DividerThemeData(
    color: GColors.black,
    // width: 0,
    thickness: 0.2,
    indent: 10,
    endIndent: 10,
  );
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
