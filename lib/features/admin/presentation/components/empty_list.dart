import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String? text;
  final IconData? icon;

  const EmptyList({
    super.key,
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon ?? CustomIcons.sad,
              color: GColors.black,
              size: kNormalIconSize + 15,
            ),
            Text(
              text ?? 'Nothing here',
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
