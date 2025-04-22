import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class NoVenues extends StatelessWidget {
  final String text;
  final IconData icon;

  const NoVenues({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: GColors.black,
              size: kNormalIconSize,
            ),
            Text(
              text,
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
