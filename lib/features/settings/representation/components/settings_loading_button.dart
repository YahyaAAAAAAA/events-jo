import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsLoadingButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry buttonPadding;

  const SettingsLoadingButton({
    super.key,
    required this.padding,
    required this.buttonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: null,
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
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CircularProgressIndicator(color: GColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
