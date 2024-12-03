import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class EventsJoLogoAuth extends StatelessWidget {
  const EventsJoLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.only(left: 13, right: 13, bottom: 13, top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GColors.whiteShade3,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientIcon(
              icon: CustomIcons.eventsjo,
              gradient: GColors.logoGradient,
              size: 80,
            ),
            GradientText(
              'EventsJo',
              gradient: GColors.logoGradient,
              style: TextStyle(
                color: GColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
