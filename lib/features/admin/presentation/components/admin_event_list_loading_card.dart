import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminEventListLoadingCard extends StatelessWidget {
  const AdminEventListLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      containersColor: GColors.white,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => AdminEventsCard(
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
