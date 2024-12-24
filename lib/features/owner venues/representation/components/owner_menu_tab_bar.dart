import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_tab_item.dart';
import 'package:events_jo/features/owner%20venues/representation/components/owner_tab_item.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/approved/owner_approved_venues_cubit.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/approved/owner_approved_venues_states.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/unapproved/owner_unapproved_venues_cubit.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/unapproved/owner_unapproved_venues_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerMenuTabBar extends StatelessWidget {
  final TabController controller;

  const OwnerMenuTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: TabBar(
          controller: controller,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: GColors.royalBlue,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: GColors.royalBlue,
          tabs: [
            BlocBuilder<OwnerApprovedVenuesCubit, OwnerApprovedVenuesStates>(
              builder: (context, state) {
                if (state is OwnerApprovedVenuesLoaded) {
                  return AdminTabItem(
                    title: 'Approved',
                    count: state.venues.length,
                  );
                }
                //return normal tab if not loaded
                else {
                  return const AdminTabItem(
                    title: 'Approved',
                    count: 0,
                  );
                }
              },
            ),
            BlocBuilder<OwnerUnapprovedVenuesCubit,
                OwnerUnapprovedVenuesStates>(
              builder: (context, state) {
                if (state is OwnerUnapprovedVenuesLoaded) {
                  return OwnerTabItem(
                    title: 'Unapproved',
                    count: state.venues.length,
                  );
                }
                //return normal tab if not loaded
                else {
                  return const OwnerTabItem(
                    title: 'Unapproved',
                    count: 0,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
