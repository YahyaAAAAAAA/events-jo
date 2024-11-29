import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text(
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
        ],
      ),
    );
  }
}
