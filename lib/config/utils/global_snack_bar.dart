import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//global snackbar, shows error message
class GSnackBar {
  static show({
    required BuildContext context,
    required String text,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? Duration(seconds: 4),
        backgroundColor: GColors.poloBlue,
        padding: const EdgeInsets.all(18),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        content: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: GColors.white,
          ),
        ),
      ),
    );
  }
}
