import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingAdminBar extends StatelessWidget {
  final bool? withImage;
  const GlobalLoadingAdminBar({
    super.key,
    this.withImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          withImage!
              ? GradientIcon(
                  icon: CustomIcons.eventsjo,
                  gradient: GColors.adminGradient,
                  size: 100,
                )
              : const SizedBox(),
          withImage! ? const SizedBox(height: 20) : const SizedBox(),
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
