import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class SelectEventMeals extends StatelessWidget {
  final TextEditingController mealNameController;
  final TextEditingController mealAmountController;
  final TextEditingController mealPriceController;

  final List<WeddingVenueMeal> meals;
  final void Function()? onAddPressed;

  final Widget Function(BuildContext, int) itemBuilder;

  const SelectEventMeals({
    super.key,
    required this.mealNameController,
    required this.mealAmountController,
    required this.mealPriceController,
    required this.meals,
    required this.onAddPressed,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height > 500 ? 140 : 0),
      child: ListView(
        children: [
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
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AuthTextField(
                    controller: mealNameController,
                    hintText: 'Meal Name',
                    obscureText: false,
                    maxLength: 14,
                  ),
                ),
              ),
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
                    maxLength: 6,
                    hintText: 'Meal Amount',
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
                    maxLength: 6,
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
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
