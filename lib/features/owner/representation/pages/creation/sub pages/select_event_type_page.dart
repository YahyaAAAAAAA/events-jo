import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* This page lets the user to pick the event type (NOT REQUIRED)
//default is a Wedding Venue if empty
class SelectEventType extends StatelessWidget {
  final EventType eventType;
  final void Function(EventType)? onSelected;

  const SelectEventType({
    super.key,
    required this.eventType,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
                  eventType == EventType.venue
                      ? CustomIcons.wedding
                      : eventType == EventType.farm
                          ? CustomIcons.farm
                          : CustomIcons.football,
                  color: GColors.royalBlue,
                  size: kSmallIconSize + 5,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Your Event Type: ',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                  Text(
                    '${eventType.name.toCapitalized}',
                    style: TextStyle(
                      color: GColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          PopupMenuButton(
            onSelected: onSelected,
            icon: Icon(
              Icons.menu,
              size: kSmallIconSize,
              color: GColors.white,
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
            ),
            color: GColors.white,
            position: PopupMenuPosition.under,
            offset: const Offset(0, 20),
            constraints: const BoxConstraints.tightFor(width: 150),
            initialValue: eventType,
            tooltip: '',
            popUpAnimationStyle: AnimationStyle(
              duration: const Duration(milliseconds: 200),
            ),
            padding: const EdgeInsets.all(12),
            elevation: 1,
            itemBuilder: (BuildContext context) {
              return [
                //menu items
                PopupMenuItem(
                  value: EventType.venue,
                  child: Text(
                    'Wedding Venue',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: EventType.farm,
                  child: Text(
                    'Farm',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: EventType.court,
                  child: Text(
                    'Football Court',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}
