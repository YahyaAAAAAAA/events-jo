import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingAdminBar extends StatelessWidget {
  final bool? mainText;
  final String? subText;

  const GlobalLoadingAdminBar({
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
                  gradient: GColors.adminGradient,
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 50,
                    fontFamily: 'Gugi',
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          subText != null
              ? Text(
                  subText ?? '',
                  style: TextStyle(
                    fontSize: kNormalFontSize,
                    fontWeight: FontWeight.bold,
                    color: GColors.cyanShade6,
                  ),
                )
              : const SizedBox(),
          subText != null ? 10.height : 0.height,
          Lottie.asset(
            'assets/animations/loading_admin.json',
            frameRate: FrameRate.max,
            fit: BoxFit.contain,
            width: 60,
            height: 60,
          ),
        ],
      ),
    );
  }
}
