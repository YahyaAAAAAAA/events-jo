import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card_dashboard.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card_events.dart';
import 'package:events_jo/features/admin/presentation/components/admin_divider.dart';
import 'package:events_jo/features/admin/presentation/components/admin_error_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/events_jo_admin.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_states.dart';
import 'package:events_jo/features/admin/presentation/pages/owners/admin_owners_list_page.dart';
import 'package:events_jo/features/admin/presentation/pages/users/admin_users_list_page.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageForAdmins extends StatefulWidget {
  final AppUser? user;
  const HomePageForAdmins({
    super.key,
    required this.user,
  });

  @override
  State<HomePageForAdmins> createState() => _HomePageForAdminsState();
}

class _HomePageForAdminsState extends State<HomePageForAdmins> {
  //counts
  late final AdminUsersCountCubit adminUsersCountCubit;
  late final AdminOwnersCountCubit adminOwnersCountCubit;

  //online
  late final AdminUsersOnlineCubit adminUsersOnlineCubit;
  late final AdminOwnersOnlineCubit adminOwnersOnlineCubit;

  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;

  @override
  void initState() {
    super.initState();

    //get users count cubit
    adminUsersCountCubit = context.read<AdminUsersCountCubit>();
    adminOwnersCountCubit = context.read<AdminOwnersCountCubit>();

    //get online cubit
    adminUsersOnlineCubit = context.read<AdminUsersOnlineCubit>();
    adminOwnersOnlineCubit = context.read<AdminOwnersOnlineCubit>();

    //get venues cubits
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();

    //listen to streams
    adminUsersCountCubit.getAllUsersStream();
    adminOwnersCountCubit.getAllOwnersStream();
    adminUsersOnlineCubit.getAllOnlineUsersStream();
    adminOwnersOnlineCubit.getAllOnlineOwnersStream();
    adminUnapproveCubit.getUnapprovedWeddingVenuesStream();
    adminApproveCubit.getApprovedWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        user: widget.user,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const EventsJoLogoAdmin(),

            const SizedBox(height: 20),

            const AdminDivider(text: 'Users and Owners for EventsJo'),

            const SizedBox(height: 5),

            //* users count
            BlocBuilder<AdminUsersCountCubit, AdminUsersCountStates>(
              builder: (context, state) {
                //done
                if (state is AdminUsersCountLoaded) {
                  final users = state.users;
                  return AdminCard(
                    count: users.length.toString(),
                    icon: Icons.person,
                    text: 'Users Count : ',
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdminUsersListPage(
                        adminUsersCountCubit: adminUsersCountCubit,
                      ),
                    )),
                  );
                }
                //error
                if (state is AdminUsersCountError) {
                  return AdminErrorCard(messege: state.messege);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),

            const SizedBox(height: 20),

            //* owners count
            BlocBuilder<AdminOwnersCountCubit, AdminOwnersCountStates>(
              builder: (context, state) {
                //done
                if (state is AdminOwnersCountLoaded) {
                  final owners = state.owners;
                  return AdminCard(
                    count: owners.length.toString(),
                    icon: Icons.person_4,
                    text: 'Owners Count : ',
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdminOwnersListPage(
                        adminOwnersCountCubit: adminOwnersCountCubit,
                      ),
                    )),
                  );
                }
                //error
                if (state is AdminOwnersCountError) {
                  return AdminErrorCard(messege: state.messege);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),

            const SizedBox(height: 20),

            const AdminDivider(text: 'Online Statistics'),

            const SizedBox(height: 5),

            //* online users count
            BlocBuilder<AdminUsersOnlineCubit, AdminUsersOnlineStates>(
              builder: (context, state) {
                //done
                if (state is AdminUsersOnlineLoaded) {
                  final users = state.users;

                  return AdminCardDashboard(
                    count: users.length.toString(),
                    icon: Icons.circle,
                    text: 'Online Users   ',
                    animation: 'assets/animations/dashboard_1.json',
                  );
                }
                //error
                if (state is AdminUsersOnlineError) {
                  return AdminErrorCard(messege: state.messege);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),

            const SizedBox(height: 20),

            //* online owners count
            BlocBuilder<AdminOwnersOnlineCubit, AdminOwnersOnlineStates>(
              builder: (context, state) {
                //done
                if (state is AdminOwnersOnlineLoaded) {
                  final owners = state.owners;
                  return AdminCardDashboard(
                    count: owners.length.toString(),
                    icon: Icons.circle,
                    text: 'Online Owners',
                    animation: 'assets/animations/dashboard_2.json',
                  );
                }
                //error
                if (state is AdminOwnersOnlineError) {
                  return AdminErrorCard(messege: state.messege);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),

            const SizedBox(height: 20),

            const AdminDivider(text: 'Venues Statistics'),

            const SizedBox(height: 5),

            //* approved venues count
            BlocBuilder<AdminApproveCubit, AdminApproveStates>(
              builder: (context, state) {
                //done
                if (state is AdminApproveLoaded) {
                  final venues = state.venues;
                  return AdminCardEvents(
                    count: venues.length.toString(),
                    icon: CustomIcons.wedding,
                    text: 'Approved Venues     ',
                  );
                }
                //error
                if (state is AdminApproveError) {
                  return AdminErrorCard(messege: state.message);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),

            const SizedBox(height: 20),

            //* unapproved venues count
            BlocBuilder<AdminUnapproveCubit, AdminUnapproveStates>(
              builder: (context, state) {
                //done
                if (state is AdminUnapproveLoaded) {
                  final venues = state.venues;
                  return AdminCardEvents(
                    count: venues.length.toString(),
                    icon: CustomIcons.rings_wedding,
                    text: 'Unapproved Venues ',
                  );
                }
                //error
                if (state is AdminUnapproveError) {
                  return AdminErrorCard(messege: state.message);
                }
                //loading
                else {
                  return const AdminLoadingCard();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Divider(
        color: GColors.cyanShade6,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
