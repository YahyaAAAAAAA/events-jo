import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_loading_users_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_sub_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_users_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/admin/presentation/pages/users/admin_user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersListPage extends StatefulWidget {
  final AdminUsersCountCubit adminUsersCountCubit;

  const AdminUsersListPage({
    super.key,
    required this.adminUsersCountCubit,
  });

  @override
  State<AdminUsersListPage> createState() => _AdminUsersListPageState();
}

class _AdminUsersListPageState extends State<AdminUsersListPage> {
  @override
  void initState() {
    super.initState();

    //start listening to approved venues stream
    widget.adminUsersCountCubit.getAllUsersStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminSubAppBar(
        title: 'EventsJo Registerd Users',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: BlocConsumer<AdminUsersCountCubit, AdminUsersCountStates>(
            builder: (context, state) {
              //done
              if (state is AdminUsersCountLoaded) {
                final users = state.users;

                if (users.isEmpty) {
                  return const EmptyList(
                    icon: CustomIcons.sad,
                    text: 'EventsJo have no users',
                  );
                }

                return AnimatedListView(
                  items: users,
                  shrinkWrap: false,
                  enterTransition: [SlideInLeft()],
                  exitTransition: [SlideInLeft()],
                  insertDuration: const Duration(milliseconds: 300),
                  removeDuration: const Duration(milliseconds: 300),
                  isSameItem: (a, b) => a.uid == b.uid,
                  itemBuilder: (context, index) {
                    return AdminUsersCard(
                      name: users[index].name,
                      index: index,
                      isOnline: users[index].isOnline,
                      isLoading: false,
                      key: Key(widget.adminUsersCountCubit.generateUniqueId()),
                      //navigate to users details
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AdminUserDetailsPage(
                            user: users[index],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              //error
              if (state is AdminUsersCountError) {
                return Text(state.messege);
              }
              //loading...
              else {
                return const AdminLoadingUsersCard();
              }
            },
            listener: (context, state) {
              //error
              if (state is AdminUsersCountError) {
                GSnackBar.show(
                  context: context,
                  text: state.messege,
                  color: GColors.cyanShade6,
                  gradient: GColors.adminGradient,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
