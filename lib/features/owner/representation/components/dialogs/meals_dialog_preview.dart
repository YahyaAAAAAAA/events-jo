import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/owner_meal_card.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class MealsDialogPreview extends StatelessWidget {
  const MealsDialogPreview({
    super.key,
    required this.meals,
  });

  final List<WeddingVenueMeal> meals;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue)),
                icon: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      colors: GColors.logoGradient,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.clear,
                      color: GColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GColors.white,
            ),
            child: meals.isNotEmpty
                ? ListView.separated(
                    itemCount: meals.length,
                    padding: const EdgeInsets.all(12),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return OwnerMealCard(
                        meals: meals,
                        index: index,
                        withButton: false,
                        onPressed: null,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'You haven\'t choose any meals',
                      style: TextStyle(
                        fontSize: 17,
                        color: GColors.poloBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
