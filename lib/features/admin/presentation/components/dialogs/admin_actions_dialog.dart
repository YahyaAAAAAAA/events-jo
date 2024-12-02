import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdminActionsDialog extends StatelessWidget {
  final String text;
  final String animation;
  final Color color;
  const AdminActionsDialog({
    super.key,
    required this.text,
    required this.animation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: ClipRRect(
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
                LottieBuilder.asset(
                  animation,
                  frameRate: FrameRate.max,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
