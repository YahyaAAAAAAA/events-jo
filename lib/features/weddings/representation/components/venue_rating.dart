import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';

class VenueRating extends StatelessWidget {
  final WeddingVenue weddingVenue;
  final double size;
  const VenueRating({
    super.key,
    required this.weddingVenue,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 1 ? GColors.fullRate : GColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 2 ? GColors.fullRate : GColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 3 ? GColors.fullRate : GColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 4 ? GColors.fullRate : GColors.emptyRate,
          size: size,
        ),
        Icon(
          Icons.star,
          color: weddingVenue.rate >= 5 ? GColors.fullRate : GColors.emptyRate,
          size: size,
        ),
      ],
    );
  }
}
