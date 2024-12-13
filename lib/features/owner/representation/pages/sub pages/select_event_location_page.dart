import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/owner/representation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
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
    return Center(
      child: ListView(
        children: [
          const OwnerPageBar(),

          const SizedBox(height: 100),

          //location button
          OwnerButton(
            text: eventType == EventType.venue
                ? 'Select your Venue location'
                : eventType == EventType.farm
                    ? 'Select your Farm location'
                    : 'Select your Court location',
            icon: Icons.location_on_outlined,
            fontSize: 20,
            iconSize: 40,
            padding: 20,
            fontWeight: FontWeight.bold,
            onPressed: onPressed,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
