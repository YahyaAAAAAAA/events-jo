import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdminDashboardCard extends StatelessWidget {
  final String count;
  final String text;
  final String animation;
  final IconData icon;

  const AdminDashboardCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kOuterRadius),
          color: GColors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(kOuterRadius),
              ),
              child: LottieBuilder.asset(
                animation,
                frameRate: const FrameRate(60),
                width: 60,
                height: 60,
              ),
            ),
            10.width,
            Text(
              '$text $count',
              style: TextStyle(
                color: GColors.black,
                fontSize: kNormalFontSize - 3,
              ),
            ),
          ],
        ));
  }
}
