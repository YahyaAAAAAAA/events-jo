import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_events_card.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venue_details_page.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venue_orders_page.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OwnerVenuesListPage extends StatelessWidget {
  final List<WeddingVenueDetailed>? detailedVenues;
  final void Function()? onRefreshPressed;

  const OwnerVenuesListPage({
    super.key,
    required this.detailedVenues,
    this.onRefreshPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kListViewWidth),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Your Wedding Venues",
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: onRefreshPressed,
                    style: Theme.of(context).iconButtonTheme.style?.copyWith(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.scaffoldBg,
                          ),
                        ),
                    icon: const Icon(
                      Icons.refresh_rounded,
                    ),
                  ),
                ],
              ),
              detailedVenues == null
                  ? Skeletonizer(
                      enabled: true,
                      containersColor: GColors.white,
                      child: ListView.separated(
                        itemCount: 5,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => 10.height,
                        itemBuilder: (context, index) =>
                            const OwnerEventsCard(venue: null),
                      ),
                    )
                  : detailedVenues!.isEmpty
                      ? const EmptyList()
                      : ListView.separated(
                          itemCount: detailedVenues!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => 10.height,
                          itemBuilder: (context, index) => OwnerEventsCard(
                            venue: detailedVenues![index].venue,
                            onOrdersPressed: () => context.push(
                              OwnerVenueOrdersPage(
                                venueName: detailedVenues![index].venue.name,
                                venueId: detailedVenues![index].venue.id,
                              ),
                            ),
                            onEditPressed: () => context.push(
                              OwnerApprovedVenueDetailsPage(
                                weddingVenue: detailedVenues![index].venue,
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
