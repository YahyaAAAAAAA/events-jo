import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final bool isLoading;

  const AdminButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.cyanShade6),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius),
          ),
        ),
      ),
      icon: Icon(
        icon,
        color: GColors.white,
        size: kSmallIconSize,
      ),
    );
  }
}
