import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LocationLoadingDialog {
  static showLocationLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AlertDialog(
              backgroundColor: GColors.poloBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: GColors.poloBlue,
                  width: 7,
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                SizedBox(
                  height: 120,
                  child: OverflowBox(
                    minHeight: 200,
                    maxHeight: 300,
                    child: Lottie.asset(
                      'assets/animations/location_loading.json',
                      frameRate: const FrameRate(60),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Getting your location, please wait...',
                    style: TextStyle(
                      color: GColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
