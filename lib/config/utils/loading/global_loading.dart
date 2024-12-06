import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingBar extends StatelessWidget {
  final bool? mainText;
  final String? subText;
  const GlobalLoadingBar({
    super.key,
    this.mainText = true,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mainText!
              ? GradientText(
                  'Ej',
                  gradient: GColors.logoGradient,
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 80,
                    fontFamily: 'Gugi',
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          subText != null
              ? GradientText(
                  subText ?? '',
                  gradient: GColors.logoGradient,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          subText != null ? const SizedBox(height: 20) : const SizedBox(),
          Lottie.asset(
            'assets/animations/loading.json',
            frameRate: FrameRate.max,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
