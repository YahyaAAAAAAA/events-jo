import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

//* This page lets the user to pick a name for their event (REQUIRED)
class SelectEventNamePage extends StatelessWidget {
  const SelectEventNamePage({
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
        //logo icon
        GradientIcon(
          icon: CustomIcons.events_jo,
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

        Text(
          selectedEventType == 0
              ? 'Enter your Wedding Venue name'
              : selectedEventType == 1
                  ? 'Enter your Farm name'
                  : 'Enter your Football Court name',
          style: TextStyle(
            color: GColors.poloBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        //name text field
        Padding(
          padding: const EdgeInsets.all(12),
          child: AuthTextField(
            controller: nameController,
            hintText: '',
            textColor: GColors.royalBlue,
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
