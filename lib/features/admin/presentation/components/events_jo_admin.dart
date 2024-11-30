import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class EventsJoLogoAdmin extends StatelessWidget {
  const EventsJoLogoAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 13, top: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.white,
        border: Border(
          left: BorderSide(
            color: GColors.cyanShade6,
            width: 10,
          ),
          right: BorderSide(
            color: GColors.cyanShade6,
            width: 10,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: GColors.cyan.withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 90),
            GradientIcon(
              icon: CustomIcons.eventsjo,
              gradient: GColors.adminGradient,
              size: 80,
            ),
            GradientText(
              'EventsJo',
              gradient: GColors.adminGradient,
              style: TextStyle(
                color: GColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 90),
          ],
        ),
      ),
    );
  }
}
