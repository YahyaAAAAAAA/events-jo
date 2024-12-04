import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingAdminBar extends StatelessWidget {
  final bool? mainText;
  const GlobalLoadingAdminBar({
    super.key,
    this.mainText = true,
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
                  gradient: GColors.adminGradient,
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 80,
                    fontFamily: 'Gugi',
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          Lottie.asset(
            'assets/animations/loading_admin.json',
            frameRate: const FrameRate(60),
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
