import 'package:flutter/material.dart';

class Shadows {
  static List<BoxShadow> soft({Color color = Colors.black}) {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 10,
        spreadRadius: 0,
        offset: const Offset(0, 4),
      ),
    ];
  }

  //note you should add to the widget 1-margin same value as 'blurRadius'
  //2-and wrap it with a ClipRRect with the same 'borderRadius'
  static List<BoxShadow> elevation({Color color = Colors.grey}) {
    return [
      BoxShadow(
        color: color,
        offset: const Offset(0, 1),
        blurRadius: 1,
      ),
    ];
  }
}
