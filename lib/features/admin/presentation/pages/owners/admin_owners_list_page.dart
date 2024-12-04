import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_sub_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_users_card.dart';
import 'package:events_jo/features/admin/presentation/components/no_requests_left.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_states.dart';
import 'package:events_jo/features/admin/presentation/pages/owners/admin_owner_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOwnersListPage extends StatefulWidget {
  final AdminOwnersCountCubit adminOwnersCountCubit;

  const AdminOwnersListPage({
    super.key,
    required this.adminOwnersCountCubit,
  });

  @override
  State<AdminOwnersListPage> createState() => _AdminUsersListPageState();
}

class _AdminUsersListPageState extends State<AdminOwnersListPage> {
  @override
  void initState() {
    super.initState();

    //start listening to approved venues stream
    widget.adminOwnersCountCubit.getAllOwnersStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminSubAppBar(
        title: 'EventsJo Registerd Owners',
      ),
      body: BlocConsumer<AdminOwnersCountCubit, AdminOwnersCountStates>(
        builder: (context, state) {
          //done
          if (state is AdminOwnersCountLoaded) {
            final owners = state.owners;

            if (owners.isEmpty) {
              return const NoRequestsLeft(
                icon: CustomIcons.sad,
                text: 'EventsJo have no owners',
              );
            }

            return AnimatedListView(
              items: owners,
              shrinkWrap: true,
              enterTransition: [SlideInLeft()],
              exitTransition: [SlideInLeft()],
              insertDuration: const Duration(milliseconds: 300),
              removeDuration: const Duration(milliseconds: 300),
              isSameItem: (a, b) => a.uid == b.uid,
              itemBuilder: (context, index) {
                return AdminUsersCard(
                  name: owners[index].name,
                  index: index,
                  isOnline: owners[index].isOnline,
                  key: Key(widget.adminOwnersCountCubit.generateUniqueId()),
                  //navigate to owner details
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminOwnerDetailsPage(
                        owner: owners[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          //error
          if (state is AdminOwnersCountError) {
            return Text(state.messege);
          }
          //loading...
          else {
            return const GlobalLoadingAdminBar(mainText: false);
          }
        },
        listener: (context, state) {
          //error
          if (state is AdminOwnersCountError) {
            GSnackBar.show(
              context: context,
              text: state.messege,
              color: GColors.cyanShade6,
            );
          }
        },
      ),
    );
  }
}
