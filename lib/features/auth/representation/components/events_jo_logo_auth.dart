import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';

class EventsJoLogoAuth extends StatelessWidget {
  const EventsJoLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.only(left: 13, right: 13, bottom: 0, top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GColors.whiteShade3,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientText(
              'Ej',
              gradient: GColors.logoGradient,
              style: TextStyle(
                color: GColors.royalBlue,
                fontSize: 60,
                fontFamily: 'Gugi',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GradientText(
                'EventsJo',
                gradient: GColors.logoGradient,
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
