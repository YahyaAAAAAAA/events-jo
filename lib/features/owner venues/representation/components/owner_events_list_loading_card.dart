import 'package:events_jo/features/owner%20venues/representation/components/owner_events_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OwnerEventsListLoadingCard extends StatelessWidget {
  const OwnerEventsListLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => OwnerEventsCard(
          name: '            ',
          index: index,
          owner: '      ',
          isApproved: false,
          isBeingApproved: false,
          isLoading: true,
          onPressed: null,
        ),
      ),
    );
  }
}
