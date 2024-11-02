import 'package:events_jo/config/utils/global_colors.dart';
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
          color: weddingVenue.rate >= 1
              ? GlobalColors.fullRate
              : GlobalColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 2
              ? GlobalColors.fullRate
              : GlobalColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 3
              ? GlobalColors.fullRate
              : GlobalColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 4
              ? GlobalColors.fullRate
              : GlobalColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 5
              ? GlobalColors.fullRate
              : GlobalColors.emptyRate,
          size: size,
        ),
      ],
    );
  }
}
