import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_error_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/events_jo_admin.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageForAdmins extends StatefulWidget {
  const HomePageForAdmins({super.key});

  @override
  State<HomePageForAdmins> createState() => _HomePageForAdminsState();
}

class _HomePageForAdminsState extends State<HomePageForAdmins> {
  late final AdminUsersCountCubit adminUsersCountCubit;
  late final AdminOwnersCountCubit adminOwnersCountCubit;

  @override
  void initState() {
    super.initState();

    //get users count cubit
    adminUsersCountCubit = context.read<AdminUsersCountCubit>();
    adminOwnersCountCubit = context.read<AdminOwnersCountCubit>();

    adminUsersCountCubit.getAllUsersStream();
    adminOwnersCountCubit.getAllOwnersStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          onPressed: () => context.read<AuthCubit>().logout(),
          icon: Icons.person,
          size: 25,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //AdminSingedInUsersCubit, Counts of approved & unapproved venues.
            //isOnline property for users (logout method needs to change)
            //buttons methods
            const EventsJoLogoAdmin(),

            const SizedBox(height: 20),

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
                    onPressed: null,
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
                    onPressed: null,
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
            )
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
