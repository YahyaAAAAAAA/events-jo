import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class EventAddedSuccessfully extends StatelessWidget {
  final void Function()? onPressed;
  final int selectedEventType;
  const EventAddedSuccessfully({
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
        GradientIcon(
          icon: CustomIcons.events_jo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),
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
        Spacer(),
        OwnerButton(
          text: selectedEventType == 0
              ? 'Congrats your Venue has been added'
              : selectedEventType == 1
                  ? 'Congrats your Farm has been added'
                  : 'Congrats your Court has been added',
          icon: CustomIcons.home,
          fontSize: 20,
          iconSize: 40,
          padding: 20,
          fontWeight: FontWeight.bold,
          onPressed: onPressed,
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
