import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:flutter/material.dart';

class OwnerDrinkCard extends StatelessWidget {
  final int index;
  final List<WeddingVenueDrink> drinks;
  final void Function()? onPressed;
  final bool withButton;
  final Color textColor;

  const OwnerDrinkCard({
    super.key,
    required this.drinks,
    required this.index,
    required this.onPressed,
    this.textColor = const Color(0xFF306BDD),
    this.withButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: GColors.whiteShade3,
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (index + 1).toString() +
                      '.  Name: ' +
                      drinks[index].name +
                      ' | Amount: ' +
                      drinks[index].amount.toString() +
                      ' | Price: ' +
                      drinks[index].price.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //remove meal
              withButton
                  ? IconButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(GColors.white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: GColors.redShade3,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
