import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsTextButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry buttonPadding;
  final void Function()? onPressed;

  const SettingsTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.padding,
    required this.buttonPadding,
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
            GColors.black.withValues(alpha: 0.5),
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
            gradient: GColors.logoGradient,
          ),
          child: Padding(
            padding: buttonPadding,
            child: Text(
              text,
              style: TextStyle(
                color: GColors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
