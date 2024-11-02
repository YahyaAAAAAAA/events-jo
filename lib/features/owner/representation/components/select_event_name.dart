import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class SelectEventName extends StatelessWidget {
  const SelectEventName({
    super.key,
    required this.selectedEventType,
    required this.nameController,
  });

  final int selectedEventType;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GlobalColors.logoGradient,
          ),
          size: 100,
        ),
        GradientText(
          'EventsJo for Owners',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GlobalColors.logoGradient,
          ),
          style: TextStyle(
            color: GlobalColors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          selectedEventType == 0
              ? 'Enter your Wedding Venue name'
              : selectedEventType == 1
                  ? 'Enter your Farm name'
                  : 'Enter your Football Court name',
          style: TextStyle(
            color: GlobalColors.poloBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AuthTextField(
            controller: nameController,
            hintText: '',
            textColor: GlobalColors.royalBlue,
            fontWeight: FontWeight.bold,
            obscureText: false,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
