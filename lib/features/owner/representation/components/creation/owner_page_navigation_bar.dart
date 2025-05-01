import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerPageNavigationBar extends StatelessWidget {
  final EventType eventType;
  final void Function()? onPressed;

  const OwnerPageNavigationBar({
    super.key,
    required this.onPressed,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      decoration: BoxDecoration(
        color: GColors.whiteShade3.shade600,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kOuterRadius),
          topRight: Radius.circular(kOuterRadius),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.all(12),
          ),
        ),
        icon: Row(
          spacing: 10,
          children: [
            //back button
            Icon(
              Icons.event_rounded,
              color: GColors.white,
              size: kNormalIconSize,
            ),
            Text(
              'Done? Submit your ${eventType.name} now',
              style: TextStyle(
                color: GColors.white,
                fontSize: kSmallFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
