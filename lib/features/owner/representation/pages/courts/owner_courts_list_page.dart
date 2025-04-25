import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_events_card.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_court_details_page.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_court_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OwnerCourtsListPage extends StatelessWidget {
  final List<FootballCourt>? footballCourts;
  final void Function()? onRefreshPressed;

  const OwnerCourtsListPage({
    super.key,
    required this.footballCourts,
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
                    "Your Football Courts",
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
              footballCourts == null
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
                  : footballCourts!.isEmpty
                      ? const EmptyList()
                      : ListView.separated(
                          itemCount: footballCourts!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => 10.height,
                          itemBuilder: (context, index) => OwnerEventsCard(
                            venue: footballCourts![index],
                            onOrdersPressed: () => context.push(
                              OwnerCourtOrdersPage(
                                courtName: footballCourts![index].name,
                                courtId: footballCourts![index].id,
                              ),
                            ),
                            onEditPressed: () => context.push(
                              OwnerApprovedCourtDetailsPage(
                                footballCourt: footballCourts![index],
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
