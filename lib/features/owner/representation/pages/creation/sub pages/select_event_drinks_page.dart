import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/creation/food_card.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_bar.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:flutter/material.dart';

class SelectEventDrinksPage extends StatelessWidget {
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
      children: [
        const OwnerPageBar(),

        const SizedBox(height: 10),

        //* text
        Center(
          child: Text(
            'Please add Drinks you offer in your Wedding Venue',
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
                  drinkNameController.text,
                  FoodType.drink,
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
                color: GColors.royalBlue,
                size: 35,
              ),
              color: GColors.white,
              constraints: const BoxConstraints(maxHeight: 200),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(GColors.white),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(9)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                shadowColor: WidgetStatePropertyAll(
                  GColors.black.withValues(alpha: 0.5),
                ),
                elevation: const WidgetStatePropertyAll(3),
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
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
                color: GColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: GColors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 1,
                  ),
                ]),
            child: drinks.isNotEmpty
                ? AnimatedListView(
                    items: drinks,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: itemBuilder,
                    enterTransition: [SlideInRight()],
                    exitTransition: [SlideInLeft()],
                    insertDuration: const Duration(milliseconds: 300),
                    removeDuration: const Duration(milliseconds: 300),
                    isSameItem: (a, b) => a.id == b.id,
                  )
                : Center(
                    child: Text(
                      'No Drinks Added',
                      style: TextStyle(
                        fontSize: 17,
                        color: GColors.poloBlue,
                      ),
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
