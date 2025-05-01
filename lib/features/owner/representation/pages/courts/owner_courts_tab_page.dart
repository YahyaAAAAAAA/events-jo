import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_menu_tab_bar.dart';
import 'package:events_jo/features/owner/representation/cubits/courts/owner_courts_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/courts/owner_courts_states.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_courts_list_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerCourtsTabPage extends StatefulWidget {
  const OwnerCourtsTabPage({super.key});

  @override
  State<OwnerCourtsTabPage> createState() => _OwnerCourtsTabPageState();
}

class _OwnerCourtsTabPageState extends State<OwnerCourtsTabPage>
    with SingleTickerProviderStateMixin {
  late final AppUser? user;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    //get cubit
    context.read<OwnerCourtsCubit>().getOwnerCourts(user!.uid);

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
        title: 'Manage Your Courts',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: OwnerMenuTabBar(
            controller: tabController,
          ),
        ),
      ),
      body: BlocConsumer<OwnerCourtsCubit, OwnerCourtsStates>(
        listener: (BuildContext context, OwnerCourtsStates state) {
          if (state is OwnerCourtsError) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            children: [
              OwnerCourtsListPage(
                onRefreshPressed: () =>
                    context.read<OwnerCourtsCubit>().getOwnerCourts(user!.uid),
                footballCourts: state is OwnerCourtsLoaded
                    ? state.courts
                        .where(
                          (detail) => detail.isApproved == true,
                        )
                        .toList()
                    : null,
              ),
              OwnerCourtsListPage(
                onRefreshPressed: () =>
                    context.read<OwnerCourtsCubit>().getOwnerCourts(user!.uid),
                footballCourts: state is OwnerCourtsLoaded
                    ? state.courts
                        .where(
                          (detail) => detail.isApproved == false,
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
