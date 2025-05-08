import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/owner/representation/components/creation/food_card.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:flutter/material.dart';

class SelectEventDrinksPage extends StatelessWidget {
  final EventType eventType;

  final TextEditingController drinkNameController;
  final TextEditingController drinkAmountController;
  final TextEditingController drinkPriceController;

  final List<WeddingVenueDrink> drinks;

  final void Function()? onAddPressed;
  final void Function(String)? onChanged;

  final Widget Function(BuildContext, int) itemBuilder;
  final void Function(dynamic)? onDrinkSelected;

  const SelectEventDrinksPage({
    super.key,
    required this.eventType,
    required this.drinkNameController,
    required this.drinkAmountController,
    required this.drinkPriceController,
    required this.drinks,
    required this.onAddPressed,
    required this.onChanged,
    required this.itemBuilder,
    required this.onDrinkSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        //* text
        Center(
          child: Text(
            'Add drinks you offer in your ${eventType.name}',
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
        ),

        //* name field
        Row(
          children: [
            Flexible(
              child: FoodCard(
                imageUrl: ImageForString.get(
                  drinkNameController.text,
                  FoodType.drink,
                ),
                padding: const EdgeInsets.only(left: 12),
                width: 60,
                height: 60,
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AuthTextField(
                  controller: drinkNameController,
                  onChanged: onChanged,
                  hintText: 'Drink Name',
                  elevation: 3,
                  obscureText: false,
                  maxLength: 25,
                ),
              ),
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.menu_open_rounded,
                color: GColors.white,
                size: kNormalIconSize,
              ),
              color: GColors.white,
              constraints: const BoxConstraints(maxHeight: 200),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(0),
              ),
              onSelected: onDrinkSelected,
              tooltip: '',
              enableFeedback: false,
              position: PopupMenuPosition.under,
              itemBuilder: (context) {
                final drinksList =
                    ImageForString.stringToImageDrinksMap.keys.toList();
                return List.generate(
                  drinksList.length,
                  (index) {
                    return PopupMenuItem(
                      value: drinksList[index].toString().toTitleCase,
                      child: Text(
                        drinksList[index].toString().toTitleCase,
                        style: TextStyle(
                          color: GColors.royalBlue,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),

        //* amount and price fields
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AuthTextField(
                  controller: drinkAmountController,
                  hintText: 'Drink Amount',
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
                  controller: drinkPriceController,
                  hintText: 'Drink Price',
                  elevation: 3,
                  inputType: TextFieldInputType.doubles,
                  obscureText: false,
                  maxLength: 7,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  onPressed: onAddPressed,
                  padding: const EdgeInsets.all(12),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                  ),
                  icon: Text(
                    'Add Drink',
                    style: TextStyle(
                      color: GColors.white,
                      fontSize: kSmallFontSize,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),

        //* list
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            child: drinks.isNotEmpty
                ? ListView.builder(
                    itemCount: drinks.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: itemBuilder,
                  )
                : Center(
                    child: Text(
                      'No Drinks Added',
                      style: TextStyle(
                        fontSize: kSmallFontSize,
                        color: GColors.black,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
