import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueDetailsButton extends StatelessWidget {
  final void Function()? onPressed;
  final double iconSize;
  final double padding;
  final IconData icon;

  const VenueDetailsButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconSize,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
          shadowColor: WidgetStatePropertyAll(
            GColors.black.withValues(alpha: 0.5),
          ),
          elevation: const WidgetStatePropertyAll(3),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
      icon: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: GColors.logoGradient,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            icon,
            size: iconSize,
            color: GColors.white,
          ),
        ),
      ),
    );
  }
}
