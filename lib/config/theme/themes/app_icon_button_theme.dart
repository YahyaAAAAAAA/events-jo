import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

IconButtonThemeData appIconButtonTheme() {
  return IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(GColors.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
      ),
    ),
  );
}
