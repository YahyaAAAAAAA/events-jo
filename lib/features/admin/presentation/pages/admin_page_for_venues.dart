import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_menu_tab_bar.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venues_page.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venues_page.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPageForVenues extends StatefulWidget {
  const AdminPageForVenues({
    super.key,
  });

  @override
  State<AdminPageForVenues> createState() => _AdminPageForVenuesState();
}

class _AdminPageForVenuesState extends State<AdminPageForVenues>
    with SingleTickerProviderStateMixin {
  //user
  late final AppUser? user;

  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    //get cubit
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();

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
        title: 'Manage Wedding Venues',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AdminMenuTabBar(
            controller: tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          const AdminUnapprovedVenuesPage(),
          const AdminApprovedVenuesPage(),
        ],
      ),
      bottomNavigationBar: Divider(
        color: GColors.poloBlue,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
        height: 0,
      ),
    );
  }
}
