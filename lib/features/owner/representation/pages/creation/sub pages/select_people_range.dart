import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_bar.dart';
import 'package:flutter/material.dart';

class SelectPeopleRange extends StatelessWidget {
  const SelectPeopleRange({
    super.key,
    required this.peoplePriceController,
    required this.peopleMinController,
    required this.peopleMaxController,
  });

  final TextEditingController peoplePriceController;
  final TextEditingController peopleMinController;
  final TextEditingController peopleMaxController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const OwnerPageBar(),

          const SizedBox(height: 100),

          //* text
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Please add the price per pesron for your Venue',
              style: TextStyle(
                color: GColors.poloBlue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
                    hintText: 'Price per person',
                    elevation: 3,
                    obscureText: false,
                    inputType: TextFieldInputType.doubles,
                    maxLength: 7,
                  ),
                ),
              ),
            ],
          ),

          //* text
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Please add a minimum and maximum amount of people for your Venue',
                style: TextStyle(
                  color: GColors.poloBlue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //* min & max fields
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
