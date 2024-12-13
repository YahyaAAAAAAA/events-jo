import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/owner/representation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
import 'package:flutter/material.dart';

//* This page displays a finish text to the user
class EventAddedSuccessfullyPage extends StatelessWidget {
  final void Function()? onPressed;
  final EventType eventType;
  const EventAddedSuccessfullyPage({
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
          OwnerButton(
            text: eventType == EventType.venue
                ? 'Your Venue has been sent for admin approval'
                : eventType == EventType.farm
                    ? 'Your Farm has been  sent for admin approval'
                    : 'Your Court has been sent for admin approval',
            icon: CustomIcons.home,
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
