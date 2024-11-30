import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class OwnerPageBar extends StatelessWidget {
  const OwnerPageBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* logo icon
            GradientIcon(
              icon: CustomIcons.eventsjo,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: GColors.logoGradient,
              ),
              size: 100,
            ),

            //* logo text
            GradientText(
              'EventsJo for Owners',
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: GColors.logoGradient,
              ),
              style: TextStyle(
                color: GColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
