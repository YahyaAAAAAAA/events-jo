import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_menu_tab_bar.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/pages/courts/approved/admin_approved_courts_page.dart';
import 'package:events_jo/features/admin/presentation/pages/courts/unapproved/admin_unapproved_courts_page.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPageForCourts extends StatefulWidget {
  const AdminPageForCourts({
    super.key,
  });

  @override
  State<AdminPageForCourts> createState() => _AdminPageForCourtsState();
}

class _AdminPageForCourtsState extends State<AdminPageForCourts>
    with SingleTickerProviderStateMixin {
  //user
  late final AppUser? user;

  late final AdminUnapprovedCourtsCubit adminUnapprovedCourtsCubit;
  late final AdminApprovedCourtsCubit adminApprovedCourtsCubit;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    //get cubit
    adminUnapprovedCourtsCubit = context.read<AdminUnapprovedCourtsCubit>();
    adminApprovedCourtsCubit = context.read<AdminApprovedCourtsCubit>();

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
        title: 'Manage Football Courts',
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
          const AdminUnapprovedCourtsPage(),
          const AdminApprovedCourtsPage(),
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
