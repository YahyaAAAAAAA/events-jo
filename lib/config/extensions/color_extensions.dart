import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color get shade50 => lighten(0.4);
  Color get shade100 => lighten(0.3);
  Color get shade200 => lighten(0.2);
  Color get shade300 => lighten(0.1);
  Color get shade400 => lighten(0.05);
  //original color
  Color get shade500 => this;
  Color get shade600 => darken(0.05);
  Color get shade700 => darken(0.1);
  Color get shade800 => darken(0.2);
  Color get shade900 => darken(0.3);

  //lightens the color by increasing brightness
  Color lighten(double amount) {
    final hsl = HSLColor.fromColor(this);
    final lightened =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
  }

  //darkens the color by decreasing brightness
  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    final darkened =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkened.toColor();
  }

  bool isDark() {
    final double luminance = computeLuminance();

    //return true if the color is dark (luminance < 0.5)
    return luminance < 0.5;
  }

  Color adjustBrightness(double targetBrightness) {
    final hsvColor = HSVColor.fromColor(this);

    //adjust the brightness
    final adjustedColor = hsvColor.withValue(targetBrightness);

    return adjustedColor.toColor();
  }
}
