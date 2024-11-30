import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/menu_tab_bar.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venues.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venues.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPageForVenues extends StatefulWidget {
  final AppUser? user;

  const AdminPageForVenues({
    super.key,
    required this.user,
  });

  @override
  State<AdminPageForVenues> createState() => _AdminPageForVenuesState();
}

class _AdminPageForVenuesState extends State<AdminPageForVenues>
    with TickerProviderStateMixin {
  late final AppUser? user;
  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    //get cubit
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();
    user = widget.user;

    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //todo make appbar global
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: AppBarButton(
            onPressed: () => context.read<AuthCubit>().logout(),
            icon: Icons.person,
            size: 25,
          ),
          bottom: PreferredSize(
            //? I dont like this widget
            preferredSize: const Size.fromHeight(40),
            child: MenuTabBar(tabController: tabController),
          ),
          actions: [
            AppBarButton(
              onPressed: () {},
              icon: CustomIcons.menu,
              size: 20,
            ),
          ],
          leadingWidth: 90,
          toolbarHeight: 70,
        ),
        body: TabBarView(
          controller: tabController,
          //note: make tab bar unswappable
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            AdminUnapprovedVenues(
              adminUnapproveCubit: adminUnapproveCubit,
              tabController: tabController,
            ),
            AdminApprovedVenues(
              adminApproveCubit: adminApproveCubit,
              tabController: tabController,
            ),
          ],
        ),
        bottomNavigationBar: Divider(
          color: GColors.cyanShade6,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
      ),
    );
  }
}
