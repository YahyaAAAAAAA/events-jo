import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

//* This page lets the user to choose a location on a map (NOT REQUIRED)
//default is the user's stored location if empty
class SelectEventLocationPage extends StatelessWidget {
  final int selectedEventType;
  final void Function()? onPressed;

  const SelectEventLocationPage({
    super.key,
    required this.selectedEventType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //logo icon
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),

        //logo text
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

        const Spacer(),

        //location button
        OwnerButton(
          text: selectedEventType == 0
              ? 'Select your Venue location'
              : selectedEventType == 1
                  ? 'Select your Farm location'
                  : 'Select your Court location',
          icon: Icons.location_on_outlined,
          fontSize: 20,
          iconSize: 40,
          padding: 20,
          fontWeight: FontWeight.bold,
          onPressed: onPressed,
        ),

        const Spacer(flex: 2),
      ],
    );
  }
}
