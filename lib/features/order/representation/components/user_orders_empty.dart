import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class UserOrdersEmpty extends StatelessWidget {
  final String? text;
  final IconData? icon;

  const UserOrdersEmpty({
    super.key,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 5,
          children: [
            Icon(
              icon ?? CustomIcons.grin_beam,
              color: GColors.black,
              size: kNormalIconSize + 15,
            ),
            Text(
              text == null
                  ? 'Your orders will appear here.'
                  : '$text, your orders will appear here.',
              style: TextStyle(
                color: GColors.black,
                fontSize: kNormalFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
