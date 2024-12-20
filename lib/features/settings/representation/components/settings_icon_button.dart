import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsIconButton extends StatelessWidget {
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry buttonPadding;
  final void Function()? onPressed;
  final Gradient? gradient;

  const SettingsIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.padding,
    required this.buttonPadding,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.white),
          shadowColor: WidgetStatePropertyAll(
            GColors.black.withOpacity(0.5),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        ),
        icon: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: gradient ?? GColors.logoGradient,
          ),
          child: Padding(
            padding: buttonPadding,
            child: Icon(
              icon,
              color: GColors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
