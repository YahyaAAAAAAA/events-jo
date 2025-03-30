import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/creation/dialogs/food_on_tap_dialog.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;

  const FoodCard({
    super.key,
    required this.imageUrl,
    required this.padding,
    required this.width,
    required this.height,
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
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: GColors.white,
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
              width: width,
              height: height,
            ),
          ),
        ),
      ),
    );
  }
}
