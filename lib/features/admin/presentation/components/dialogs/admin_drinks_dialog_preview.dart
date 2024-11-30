import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/owner_drink_card.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:flutter/material.dart';

class AdminDrinksDialogPreview extends StatelessWidget {
  final List<WeddingVenueDrink> drinks;

  const AdminDrinksDialogPreview({
    super.key,
    required this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
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
                    gradient: GColors.adminGradient,
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
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GColors.white,
            ),
            child: drinks.isNotEmpty
                ? ListView.separated(
                    itemCount: drinks.length,
                    padding: const EdgeInsets.all(12),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return OwnerDrinkCard(
                        drinks: drinks,
                        index: index,
                        textColor: GColors.cyanShade6,
                        withButton: false,
                        onPressed: null,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'There are not any drinks',
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
