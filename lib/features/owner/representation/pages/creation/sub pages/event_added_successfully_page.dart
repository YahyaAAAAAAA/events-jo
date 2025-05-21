import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* This page displays a finish text to the user
class EventAddedSuccessfullyPage extends StatelessWidget {
  final void Function()? onPressed;
  final EventType eventType;
  final String? text;

  const EventAddedSuccessfullyPage({
    super.key,
    required this.eventType,
    required this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 100, child: Divider()),
          10.height,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text ??
                      'Thank you, your ${eventType.name} has been sent for admin approval',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kNormalFontSize,
                  ),
                ),
              ],
            ),
          ),
          10.height,
          IconButton(
            onPressed: onPressed,
            padding: const EdgeInsets.all(12),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
            ),
            icon: Icon(
              CustomIcons.home,
              color: GColors.white,
              size: kBigIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
