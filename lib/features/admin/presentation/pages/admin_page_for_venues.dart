import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/menu_tab_bar.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
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

class _AdminPageForVenuesState extends State<AdminPageForVenues> {
  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;

  @override
  void initState() {
    super.initState();

    //get cubit
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();
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
            onPressed: () => context
                .read<AuthCubit>()
                .logout(widget.user!.uid, widget.user!.type),
            icon: Icons.person,
            size: 25,
          ),
          bottom: const PreferredSize(
            //? I dont like this widget
            preferredSize: Size.fromHeight(40),
            child: MenuTabBar(),
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
          //note: make tab bar unswappable
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            AdminUnapprovedVenues(
              adminUnapproveCubit: adminUnapproveCubit,
            ),
            AdminApprovedVenues(
              adminApproveCubit: adminApproveCubit,
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
