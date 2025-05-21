import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:flutter/material.dart';

class SelectPeopleRange extends StatelessWidget {
  final EventType eventType;

  const SelectPeopleRange({
    super.key,
    required this.eventType,
    required this.peoplePriceController,
    required this.peopleMinController,
    required this.peopleMaxController,
    this.testPress,
  });

  final TextEditingController peoplePriceController;
  final TextEditingController peopleMinController;
  final TextEditingController peopleMaxController;
  final void Function()? testPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //* text
          FittedBox(
            fit: BoxFit.scaleDown,
            child: GestureDetector(
              onTap: testPress,
              child: Text(
                'Add the price per ${eventType == EventType.venue ? 'pesron' : 'hour'} for your ${eventType.name}',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
            ),
          ),

          //* price field
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AuthTextField(
                    controller: peoplePriceController,
                    hintText: eventType == EventType.venue
                        ? 'Price per person'
                        : 'Price per hour',
                    elevation: 3,
                    obscureText: false,
                    inputType: TextFieldInputType.doubles,
                    maxLength: 7,
                  ),
                ),
              ),
            ],
          ),

          //* min & max fields
          if (eventType == EventType.venue)
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: AuthTextField(
                      controller: peopleMinController,
                      hintText: 'Minimum Amount',
                      elevation: 3,
                      inputType: TextFieldInputType.integers,
                      obscureText: false,
                      maxLength: 7,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: AuthTextField(
                      controller: peopleMaxController,
                      hintText: 'Maximum Amount',
                      elevation: 3,
                      inputType: TextFieldInputType.integers,
                      obscureText: false,
                      maxLength: 7,
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
