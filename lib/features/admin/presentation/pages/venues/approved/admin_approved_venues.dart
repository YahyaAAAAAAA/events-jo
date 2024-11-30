import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/components/no_requests_left.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20approve/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedVenues extends StatefulWidget {
  final AdminApproveCubit adminApproveCubit;
  final TabController tabController;

  const AdminApprovedVenues({
    super.key,
    required this.adminApproveCubit,
    required this.tabController,
  });

  @override
  State<AdminApprovedVenues> createState() => _AdminApprovedVenuesState();
}

class _AdminApprovedVenuesState extends State<AdminApprovedVenues> {
  @override
  void initState() {
    super.initState();

    //start listening to approved venues stream
    widget.adminApproveCubit.getApprovedWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminApproveCubit, AdminApproveStates>(
      builder: (context, state) {
        //done
        if (state is AdminApproveLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return const NoRequestsLeft(
              icon: CustomIcons.sad,
              text: 'No Approved Venues in EventsJo',
            );
          }

          return ListView.builder(
            itemCount: venues.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AdminCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                isApproved: venues[index].isApproved,
                //navigate to venue details
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdminApprovedVenueDetails(
                      adminApproveCubit: widget.adminApproveCubit,
                      tabController: widget.tabController,
                      weddingVenue: venues[index],
                    ),
                  ),
                ),
              );
            },
          );
        }
        //error
        if (state is AdminApproveError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const GlobalLoadingAdminBar();
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminApproveError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            color: GColors.cyanShade6,
          );
        }
        //approval loading dialog
        if (state is AdminSuspendActionLoading) {
          widget.adminApproveCubit.showAdminActionsDialog(context,
              text: 'Suspending the venue please wait...', icon: Icons.check);
        }
        if (state is AdminSuspendActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Venue Suspended Successfully',
            color: GColors.cyanShade6,
          );
        }
      },
    );
  }
}
