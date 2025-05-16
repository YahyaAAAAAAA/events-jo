import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_dashboard_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_home_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_divider.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_states.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_courts.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_venues.dart';
import 'package:events_jo/features/admin/presentation/pages/owners/admin_owners_list_page.dart';
import 'package:events_jo/features/admin/presentation/pages/users/admin_users_list_page.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePageForAdmins extends StatefulWidget {
  const HomePageForAdmins({
    super.key,
  });

  @override
  State<HomePageForAdmins> createState() => _HomePageForAdminsState();
}

class _HomePageForAdminsState extends State<HomePageForAdmins> {
  //user
  late final AppUser? user;

  //counts
  late final AdminUsersCountCubit adminUsersCountCubit;
  late final AdminOwnersCountCubit adminOwnersCountCubit;

  //online
  late final AdminUsersOnlineCubit adminUsersOnlineCubit;
  late final AdminOwnersOnlineCubit adminOwnersOnlineCubit;

  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;

  late final AdminUnapprovedCourtsCubit adminUnapprovedCourtsCubit;
  late final AdminApprovedCourtsCubit adminApprovedCourtsCubit;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    //get users count cubit
    adminUsersCountCubit = context.read<AdminUsersCountCubit>();
    adminOwnersCountCubit = context.read<AdminOwnersCountCubit>();

    //get online cubit
    adminUsersOnlineCubit = context.read<AdminUsersOnlineCubit>();
    adminOwnersOnlineCubit = context.read<AdminOwnersOnlineCubit>();

    //get venues cubits
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();

    //get courts cubits
    adminUnapprovedCourtsCubit = context.read<AdminUnapprovedCourtsCubit>();
    adminApprovedCourtsCubit = context.read<AdminApprovedCourtsCubit>();

    //listen to streams
    adminUsersCountCubit.getAllUsersStream();
    adminOwnersCountCubit.getAllOwnersStream();
    adminUsersOnlineCubit.getAllOnlineUsersStream();
    adminOwnersOnlineCubit.getAllOnlineOwnersStream();
    adminUnapproveCubit.getUnapprovedWeddingVenuesStream();
    adminApproveCubit.getApprovedWeddingVenuesStream();
    adminUnapprovedCourtsCubit.getUnapprovedCourtsStream();
    adminApprovedCourtsCubit.getApprovedCourtStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: false,
        title: user?.name ?? 'Guest 123',
        onPressed: () =>
            context.read<AuthCubit>().logout(user!.uid, user!.type),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kBiglFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          GColors.black,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    icon: Text(
                      'Ej',
                      style: TextStyle(
                        fontSize: kBiglFontSize,
                        color: GColors.white,
                        fontFamily: 'Gugi',
                      ),
                    ),
                  ),
                ],
              ),

              20.height,

              const AdminDivider(text: 'Users and Owners for EventsJo'),

              5.height,

              //* users count
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  BlocBuilder<AdminUsersCountCubit, AdminUsersCountStates>(
                    builder: (context, state) => Skeletonizer(
                      enabled: state is AdminUsersCountLoaded ? false : true,
                      containersColor: GColors.white,
                      child: AdminCard(
                        count: state is AdminUsersCountLoaded
                            ? state.users.length.toString()
                            : '5',
                        icon: Icons.person,
                        text: 'Users Count:',
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminUsersListPage(
                            adminUsersCountCubit: adminUsersCountCubit,
                          ),
                        )),
                      ),
                    ),
                  ),

                  //* owners count
                  BlocBuilder<AdminOwnersCountCubit, AdminOwnersCountStates>(
                    builder: (context, state) => Skeletonizer(
                      enabled: state is AdminOwnersCountLoaded ? false : true,
                      containersColor: GColors.white,
                      child: AdminCard(
                        count: state is AdminOwnersCountLoaded
                            ? state.owners.length.toString()
                            : '5',
                        icon: Icons.person_4,
                        text: 'Owners Count:',
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AdminOwnersListPage(
                              adminOwnersCountCubit: adminOwnersCountCubit,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              20.height,

              const AdminDivider(text: 'Online Statistics'),

              5.height,

              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  //* online users count
                  BlocBuilder<AdminUsersOnlineCubit, AdminUsersOnlineStates>(
                    builder: (context, state) => Skeletonizer(
                      enabled: state is AdminUsersOnlineLoaded ? false : true,
                      containersColor: GColors.white,
                      child: AdminDashboardCard(
                        count: state is AdminUsersOnlineLoaded
                            ? state.users.length.toString()
                            : '5',
                        icon: Icons.circle,
                        text: 'Online Users:',
                        animation: 'assets/animations/dashboard_1.json',
                      ),
                    ),
                  ),

                  //* online owners count
                  BlocBuilder<AdminOwnersOnlineCubit, AdminOwnersOnlineStates>(
                    builder: (context, state) => Skeletonizer(
                      enabled: state is AdminOwnersOnlineLoaded ? false : true,
                      containersColor: GColors.white,
                      child: AdminDashboardCard(
                        count: state is AdminOwnersOnlineLoaded
                            ? state.owners.length.toString()
                            : '5',
                        icon: Icons.circle,
                        text: 'Online Owners:',
                        animation: 'assets/animations/dashboard_2.json',
                      ),
                    ),
                  ),
                ],
              ),

              20.height,

              const AdminDivider(text: 'Venues Statistics'),

              5.height,

              //* approved venues count
              BlocBuilder<AdminApproveCubit, AdminApproveStates>(
                builder: (context, state) => Skeletonizer(
                  enabled: state is AdminApproveLoaded ? false : true,
                  containersColor: GColors.white,
                  child: AdminHomeCard(
                    count: state is AdminApproveLoaded
                        ? state.venues.length.toString()
                        : '5',
                    onPressed: () => context.push(const AdminPageForVenues()),
                    icon: CustomIcons.wedding,
                    text: 'Approved Venues',
                    bgColor: GColors.greenShade3.withValues(alpha: 0.3),
                    iconColor: GColors.greenShade3.shade800,
                  ),
                ),
              ),

              20.height,

              //* unapproved venues count
              BlocBuilder<AdminUnapproveCubit, AdminUnapproveStates>(
                builder: (context, state) => Skeletonizer(
                  enabled: state is AdminUnapproveLoaded ? false : true,
                  containersColor: GColors.white,
                  child: AdminHomeCard(
                    count: state is AdminUnapproveLoaded
                        ? state.venues.length.toString()
                        : '5',
                    icon: CustomIcons.wedding,
                    text: 'Disapproved Venues',
                    onPressed: () => context.push(const AdminPageForVenues()),
                    bgColor: GColors.redShade3.withValues(alpha: 0.3),
                    iconColor: GColors.redShade3.shade800,
                  ),
                ),
              ),
              20.height,

              const AdminDivider(text: 'Courts Statistics'),

              5.height,

              //* approved courts count
              BlocBuilder<AdminApprovedCourtsCubit, AdminApprovedCourtsStates>(
                builder: (context, state) => Skeletonizer(
                  enabled: state is AdminApprovedCourtsLoaded ? false : true,
                  containersColor: GColors.white,
                  child: AdminHomeCard(
                    count: state is AdminApprovedCourtsLoaded
                        ? state.courts.length.toString()
                        : '5',
                    icon: CustomIcons.football,
                    text: 'Approved Courts',
                    onPressed: () => context.push(const AdminPageForCourts()),
                    bgColor: GColors.greenShade3.withValues(alpha: 0.3),
                    iconColor: GColors.greenShade3.shade800,
                  ),
                ),
              ),

              20.height,

              //* unapproved venues count
              BlocBuilder<AdminUnapprovedCourtsCubit,
                  AdminUnapprovedCourtsStates>(
                builder: (context, state) => Skeletonizer(
                  enabled: state is AdminUnapprovedCourtsLoaded ? false : true,
                  containersColor: GColors.white,
                  child: AdminHomeCard(
                    count: state is AdminUnapprovedCourtsLoaded
                        ? state.courts.length.toString()
                        : '5',
                    icon: CustomIcons.football,
                    text: 'Disapproved Courts',
                    onPressed: () => context.push(const AdminPageForCourts()),
                    bgColor: GColors.redShade3.withValues(alpha: 0.3),
                    iconColor: GColors.redShade3.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
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
