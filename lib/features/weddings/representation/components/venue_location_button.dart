import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueLocationButton extends StatelessWidget {
  final void Function()? onPressed;
  final double iconSize;
  final double padding;
  final IconData icon;
  final FontWeight fontWeight;

  const VenueLocationButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconSize,
    required this.padding,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
          shadowColor: WidgetStatePropertyAll(
            GColors.black.withOpacity(0.5),
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
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
