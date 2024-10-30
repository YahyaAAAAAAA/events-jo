import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';

class VenuesRating extends StatelessWidget {
  final WeddingVenue weddingVenue;
  final double size;
  const VenuesRating({
    super.key,
    required this.weddingVenue,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color:
              weddingVenue.rate >= 1 ? MyColors.fullRate : MyColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color:
              weddingVenue.rate >= 2 ? MyColors.fullRate : MyColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color:
              weddingVenue.rate >= 3 ? MyColors.fullRate : MyColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color:
              weddingVenue.rate >= 4 ? MyColors.fullRate : MyColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color:
              weddingVenue.rate >= 5 ? MyColors.fullRate : MyColors.emptyRate,
          size: size,
        ),
      ],
    );
  }
}
