import 'package:events_jo/features/owner%20venues/representation/components/owner_menu_tab_bar.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/unapproved/owner_unapproved_venues_cubit.dart';
import 'package:events_jo/features/owner%20venues/representation/pages/venues/approved/owner_approved_venues_page.dart';
import 'package:events_jo/features/owner%20venues/representation/pages/venues/unapproved/owner_unapproved_venues_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerVenues extends StatefulWidget {
  const OwnerVenues({super.key});

  @override
  State<OwnerVenues> createState() => _OwnerVenuesState();
}

class _OwnerVenuesState extends State<OwnerVenues>
    with SingleTickerProviderStateMixin {
  late final OwnerUnapprovedVenuesCubit ownerUnapprovedVenuesCubit;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    //get cubit
    ownerUnapprovedVenuesCubit = context.read<OwnerUnapprovedVenuesCubit>();

    tabController = TabController(length: 2, vsync: this);

    // ownerUnapprovedVenuesCubit.getUnapprovedVenuesStream(user!.uid);
  }

  @override
  void dispose() {
    super.dispose();

    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsSubAppBar(
        title: 'Your Venues',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: OwnerMenuTabBar(
            controller: tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          const OwnerApprovedVenuesPage(),
          const OwnerUnapprovedVenuesPage(),
        ],
      ),
    );
  }
}
