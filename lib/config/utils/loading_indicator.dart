import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientIcon(
            icon: CustomIcons.events_jo,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: GColors.logoGradient,
            ),
            size: 100,
          ),
          SizedBox(height: 20),
          Lottie.asset(
            'assets/animations/loading.json',
            frameRate: const FrameRate(60),
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
