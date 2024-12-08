import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_card.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar.dart';
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
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const VenueSearchBar(
              controller: null,
              onPressed: null,
              onChanged: null,
            );
          }
          return VenueCard(
            user: null,
            //disable colors
            isLoading: true,
            //dummy object
            weddingVenue: WeddingVenue(
              id: 'x',
              name: 'Loading',
              latitude: 0,
              longitude: 0,
              rate: 0,
              isOpen: true,
              isApproved: true,
              isBeingApproved: false,
              pics: ["https://i.ibb.co/ZVf53hB/placeholder.png"],
              ownerId: 'x',
              ownerName: 'x',
              startDate: [],
              endDate: [],
              time: [],
              peopleMax: 1,
              peopleMin: 0,
              peoplePrice: 1,
            ),
          );
        },
      ),
    );
  }
}
