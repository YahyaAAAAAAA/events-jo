import 'package:events_jo/config/utils/dummy.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/events/weddings/representation/components/venue_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VenuesListLoading extends StatelessWidget {
  const VenuesListLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      containersColor: GColors.white,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
        ),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return VenueCard(
            user: null,
            weddingVenue: Dummy.venue,
          );
        },
      ),
    );
  }
}
