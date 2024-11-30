import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class AdminActionsDialog extends StatelessWidget {
  final IconData icon;
  final String text;
  const AdminActionsDialog({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          backgroundColor: GColors.whiteShade3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          scrollable: true,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientIcon(
                icon: icon,
                gradient: GColors.adminGradient,
                size: 60,
              ),
              const SizedBox(height: 20),
              GradientText(
                text,
                gradient: GColors.adminGradient,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
