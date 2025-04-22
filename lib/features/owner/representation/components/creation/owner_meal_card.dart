import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class OwnerMealCard extends StatelessWidget {
  final int index;
  final List<WeddingVenueMeal> meals;
  final void Function()? onPressed;
  final bool withButton;
  final Color textColor;

  const OwnerMealCard({
    super.key,
    required this.meals,
    required this.index,
    required this.onPressed,
    this.textColor = const Color(0xFF306BDD),
    this.withButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: GColors.whiteShade3,
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              //note: expand text makes it wrap
              Expanded(
                child: Text(
                  (index + 1).toString() +
                      '.  Name: ' +
                      meals[index].name +
                      ' | Amount: ' +
                      meals[index].amount.toString() +
                      ' | Price: ' +
                      meals[index].price.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
