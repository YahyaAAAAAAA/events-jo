import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* This page lets the user to choose a location on a map (NOT REQUIRED)
//default is the user's stored location if empty
class SelectEventLocationPage extends StatelessWidget {
  final EventType eventType;
  final void Function()? onPressed;

  const SelectEventLocationPage({
    super.key,
    required this.eventType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        spacing: 10,
        children: [
          IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(GColors.whiteShade3.shade600),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              Icons.location_on_outlined,
              color: GColors.royalBlue,
              size: kSmallIconSize + 5,
            ),
          ),
          Text(
            'Your ${eventType.name.toCapitalized} Location',
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: GColors.white,
              size: kSmallIconSize + 5,
            ),
          ),
        ],
      ),
    );
  }
}
