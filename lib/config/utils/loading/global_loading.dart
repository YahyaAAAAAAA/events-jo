import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingBar extends StatelessWidget {
  final bool? withImage;
  final String? text;
  const GlobalLoadingBar({
    super.key,
    this.withImage = true,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withImage!
                ? GradientIcon(
                    icon: CustomIcons.eventsjo,
                    gradient: GColors.logoGradient,
                    size: 100,
                  )
                : const SizedBox(),
            withImage! ? const SizedBox(height: 20) : const SizedBox(),
            text != null
                ? GradientText(
                    text ?? '',
                    gradient: GColors.logoGradient,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(),
            text != null ? const SizedBox(height: 20) : const SizedBox(),
            Lottie.asset(
              'assets/animations/loading.json',
              frameRate: FrameRate.max,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
