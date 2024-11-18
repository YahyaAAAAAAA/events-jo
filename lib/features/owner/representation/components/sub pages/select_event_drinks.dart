import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_text.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class SelectEventDrinks extends StatelessWidget {
  final TextEditingController drinkNameController;
  final TextEditingController drinkAmountController;
  final TextEditingController drinkPriceController;

  final List<WeddingVenueDrink> drinks;
  final void Function()? onAddPressed;

  final Widget? Function(BuildContext, int) itemBuilder;

  const SelectEventDrinks({
    super.key,
    required this.drinkNameController,
    required this.drinkAmountController,
    required this.drinkPriceController,
    required this.drinks,
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
          'Please add Drinks you offer in your Wedding Venue',
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
                  controller: drinkNameController,
                  hintText: 'Drink Name',
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
                  controller: drinkAmountController,
                  hintText: 'Drink Amount',
                  isOnlyInt: true,
                  obscureText: false,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AuthTextField(
                  controller: drinkPriceController,
                  hintText: 'Drink Price',
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
          text: 'Add Drink',
        ),

        //* text
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Your Drinks',
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
              child: drinks.isNotEmpty
                  ? ListView.separated(
                      itemCount: drinks.length,
                      padding: const EdgeInsets.all(12),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: itemBuilder,
                    )
                  : Center(
                      child: Text(
                      'No Drinks Added',
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
