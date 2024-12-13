import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/owner/representation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/food_card.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class SelectEventMeals extends StatelessWidget {
  final TextEditingController mealNameController;
  final TextEditingController mealAmountController;
  final TextEditingController mealPriceController;

  final List<WeddingVenueMeal> meals;
  final void Function()? onAddPressed;
  final void Function(String)? onTextFieldChanged;

  final Widget Function(BuildContext, int) itemBuilder;
  final void Function(dynamic)? onMealSelected;

  const SelectEventMeals({
    super.key,
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
      children: [
        const OwnerPageBar(),

        const SizedBox(height: 10),

        //* text
        Center(
          child: Text(
            'Please add Meals you offer in your Wedding Venue',
            style: TextStyle(
              color: GColors.poloBlue,
              fontSize: 17,
              fontWeight: FontWeight.bold,
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
                width: 70,
                height: 70,
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
                color: GColors.royalBlue,
                size: 35,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(GColors.white),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(9)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(3),
                shadowColor: WidgetStatePropertyAll(
                  GColors.black.withOpacity(0.5),
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
                  isOnlyInt: true,
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
                  isOnlyDouble: true,
                  obscureText: false,
                ),
              ),
            ),
          ],
        ),

        //* add button
        OwnerButton(
          onPressed: onAddPressed,
          fontSize: 20,
          fontWeight: FontWeight.normal,
          icon: Icons.add,
          iconSize: 50,
          padding: 8,
          text: 'Add Meal',
        ),

        //* text
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Your Meals',
              style: TextStyle(
                color: GColors.poloBlue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: GColors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: meals.isNotEmpty
                ? AnimatedListView(
                    items: meals,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: itemBuilder,
                    enterTransition: [SlideInRight()],
                    exitTransition: [SlideInLeft()],
                    insertDuration: const Duration(milliseconds: 300),
                    removeDuration: const Duration(milliseconds: 300),
                  )
                : Center(
                    child: Text(
                      'No Meals Added',
                      style: TextStyle(
                        fontSize: 17,
                        color: GColors.poloBlue,
                      ),
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
