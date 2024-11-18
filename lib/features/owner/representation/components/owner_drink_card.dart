import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:flutter/material.dart';

class OwnerDrinkCard extends StatelessWidget {
  final int index;
  final List<WeddingVenueDrink> drinks;
  final void Function()? onPressed;
  final bool withButton;

  const OwnerDrinkCard({
    super.key,
    required this.drinks,
    required this.index,
    required this.onPressed,
    this.withButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.whiteShade3,
      ),
      padding: const EdgeInsets.all(12),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              (index + 1).toString() +
                  '.  Name: ' +
                  drinks[index].name +
                  ' | Amount: ' +
                  drinks[index].amount.toString() +
                  ' | Price: ' +
                  drinks[index].price.toString(),
              style: TextStyle(
                fontSize: 17,
                color: GColors.royalBlue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 10),

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
    );
  }
}
