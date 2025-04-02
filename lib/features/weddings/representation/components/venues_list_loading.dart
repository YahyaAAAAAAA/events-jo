import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_card.dart';
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
            //disable colors
            //dummy object
            weddingVenue: WeddingVenue(
              id: 'x',
              name: 'Loadingggggggg',
              latitude: 0,
              longitude: 0,
              rates: [],
              isOpen: true,
              isApproved: true,
              isBeingApproved: false,
              pics: [
                "https://i.ibb.co/hh5xKbD/plain-white-background-or-wallpaper-abstract-image-2-E064-N7.jpg"
              ],
              ownerId: 'x',
              ownerName: 'x',
              startDate: [],
              endDate: [],
              time: [],
              peopleMax: 1,
              peopleMin: 0,
              peoplePrice: 1,
              city: 'loadingg',
            ),
          );
        },
      ),
    );
  }
}
