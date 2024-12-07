import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/food_on_tap_dialog.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;

  const FoodCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => FoodOnTapDialog(
          image: imageUrl,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            //waiting for image
            placeholder: (context, url) => FittedBox(
              fit: BoxFit.scaleDown,
              child: CircularProgressIndicator(color: GColors.royalBlue),
            ),
            //error getting image
            errorWidget: (context, url, error) => SizedBox(
              width: 100,
              child: Icon(
                Icons.error_outline,
                color: GColors.black,
                size: 40,
              ),
            ),
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          ),
        ),
      ),
    );
  }
}
