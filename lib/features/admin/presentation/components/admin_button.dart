import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final IconData icon;
  final double padding;
  final void Function()? onPressed;

  const AdminButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return //* button
        Padding(
      padding: EdgeInsets.all(padding),
      //navigate to details page
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
            gradient: GColors.adminGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
