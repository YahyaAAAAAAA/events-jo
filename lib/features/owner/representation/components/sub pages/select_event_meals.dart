import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_text.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class SelectEventMeals extends StatelessWidget {
  final TextEditingController mealNameController;
  final TextEditingController mealAmountController;
  final TextEditingController mealPriceController;

  final List<WeddingVenueMeal> meals;
  final void Function()? onAddPressed;

  final Widget? Function(BuildContext, int) itemBuilder;

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
    return Column(
      children: [
        //* logo icon
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),

        //* logo text
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

        const SizedBox(height: 10),

        //* text
        Text(
          'Please add Meals you offer in your Wedding Venue',
          style: TextStyle(
            color: GColors.poloBlue,
            fontSize: 17,
            fontWeight: FontWeight.bold,
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
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: GColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: meals.isNotEmpty
                  ? ListView.separated(
                      itemCount: meals.length,
                      padding: const EdgeInsets.all(12),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: itemBuilder,
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
        ),
      ],
    );
  }
}
