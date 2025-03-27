import 'package:flutter/material.dart';

extension IntExtensions on int {
  SizedBox get width => this.toWidth();

  SizedBox get height => this.toHeight();

  SizedBox toWidth() {
    return SizedBox(
      width: this.toDouble(),
    );
  }

  SizedBox toHeight() {
    return SizedBox(
      height: this.toDouble(),
    );
  }
}
