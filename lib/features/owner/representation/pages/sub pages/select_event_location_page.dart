import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
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
        ],
      ),
    );
  }
}
