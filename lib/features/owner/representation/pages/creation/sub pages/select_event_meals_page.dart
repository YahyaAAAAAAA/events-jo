import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/owner/representation/components/creation/food_card.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class SelectEventMealsPage extends StatelessWidget {
  final EventType eventType;

  final TextEditingController mealNameController;
  final TextEditingController mealAmountController;
  final TextEditingController mealPriceController;

  final List<WeddingVenueMeal> meals;
  final void Function()? onAddPressed;
  final void Function(String)? onTextFieldChanged;

  final Widget Function(BuildContext, int) itemBuilder;
  final void Function(dynamic)? onMealSelected;

  const SelectEventMealsPage({
    super.key,
    required this.eventType,
    required this.mealNameController,
    required this.mealAmountController,
    required this.mealPriceController,
    required this.meals,
    required this.onAddPressed,
    required this.onTextFieldChanged,
    required this.itemBuilder,
    required this.onMealSelected,
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
            'Add meals you offer in your ${eventType.name}',
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
                  mealNameController.text,
                  FoodType.meal,
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
                  controller: mealNameController,
                  hintText: 'Meal Name',
                  elevation: 3,
                  obscureText: false,
                  maxLength: 25,
                  onChanged: onTextFieldChanged,
                ),
              ),
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.menu_open_rounded,
                color: GColors.white,
                size: kNormalIconSize,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(0),
                shadowColor: WidgetStatePropertyAll(
                  GColors.black.withValues(alpha: 0.5),
                ),
              ),
              color: GColors.white,
              constraints: const BoxConstraints(maxHeight: 200),
              onSelected: onMealSelected,
              tooltip: '',
              enableFeedback: false,
              position: PopupMenuPosition.under,
              itemBuilder: (context) {
                final mealsList =
                    ImageForString.stringToImageMealsMap.keys.toList();
                return List.generate(
                  mealsList.length,
                  (index) {
                    return PopupMenuItem(
                      value: mealsList[index].toString().toTitleCase,
                      child: Text(
                        mealsList[index].toString().toTitleCase,
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
                  controller: mealAmountController,
                  maxLength: 7,
                  hintText: 'Meal Amount',
                  elevation: 3,
                  inputType: TextFieldInputType.integers,
                  obscureText: false,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AuthTextField(
                  controller: mealPriceController,
                  hintText: 'Meal Price',
                  maxLength: 7,
                  elevation: 3,
                  inputType: TextFieldInputType.doubles,
                  obscureText: false,
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
                    'Add Meal',
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

        //* text
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Your Meals',
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
          ),
        ),

        //* list
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            child: meals.isNotEmpty
                ? ListView.builder(
                    itemCount: meals.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: itemBuilder,
                  )
                : Center(
                    child: Text(
                      'No Meals Added',
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
