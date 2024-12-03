import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class EventsJoLogo extends StatelessWidget {
  const EventsJoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 13, top: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.white,
        border: const Border(
          left: BorderSide(
            color: Color(0xFF306bdd),
            width: 10,
          ),
          right: BorderSide(
            color: Color(0xFF306bdd),
            width: 10,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: GColors.royalBlue.withOpacity(0.2),
            blurRadius: 3,
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
              gradient: GColors.logoGradient,
              size: 80,
            ),
            GradientText(
              'EventsJo',
              gradient: GColors.logoGradientReversed,
              style: TextStyle(
                color: GColors.royalBlue,
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
