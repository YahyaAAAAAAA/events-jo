import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//show error messege
class GlobalSnackBar {
  static show({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: GlobalColors.poloBlue,
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
            color: GlobalColors.white,
          ),
        ),
      ),
    );
  }
}
