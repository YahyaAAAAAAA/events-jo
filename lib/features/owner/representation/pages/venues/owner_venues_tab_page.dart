import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_menu_tab_bar.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_states.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venues_list_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerVenuesTabPage extends StatefulWidget {
  const OwnerVenuesTabPage({super.key});

  @override
  State<OwnerVenuesTabPage> createState() => _OwnerVenuesTabPageState();
}

class _OwnerVenuesTabPageState extends State<OwnerVenuesTabPage>
    with SingleTickerProviderStateMixin {
  late final AppUser? user;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    //get cubit
    context.read<OwnerVenuesCubit>().getOwnerVenues(user!.uid);

    tabController = TabController(length: 2, vsync: this);
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
        title: 'Manage Your Venues',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: OwnerMenuTabBar(
            controller: tabController,
          ),
        ),
      ),
      body: BlocConsumer<OwnerVenuesCubit, OwnerVenuesStates>(
        listener: (BuildContext context, OwnerVenuesStates state) {
          if (state is OwnerVenuesError) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            children: [
              OwnerVenuesListPage(
                onRefreshPressed: () =>
                    context.read<OwnerVenuesCubit>().getOwnerVenues(user!.uid),
                detailedVenues: state is OwnerVenuesLoaded
                    ? state.detailedVenues
                        .where(
                          (detail) => detail.venue.isApproved == true,
                        )
                        .toList()
                    : null,
              ),
              OwnerVenuesListPage(
                onRefreshPressed: () =>
                    context.read<OwnerVenuesCubit>().getOwnerVenues(user!.uid),
                detailedVenues: state is OwnerVenuesLoaded
                    ? state.detailedVenues
                        .where(
                          (detail) => detail.venue.isApproved == false,
                        )
                        .toList()
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
