import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/no_requests_left.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedVenues extends StatefulWidget {
  final AdminApproveCubit adminApproveCubit;
  const AdminApprovedVenues({
    super.key,
    required this.adminApproveCubit,
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

          return AnimatedListView(
            items: venues,
            shrinkWrap: true,
            enterTransition: [SlideInLeft()],
            exitTransition: [SlideInLeft()],
            insertDuration: const Duration(milliseconds: 300),
            removeDuration: const Duration(milliseconds: 300),
            itemBuilder: (context, index) {
              return AdminEventsCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                key: Key(widget.adminApproveCubit.generateUniqueId()),
                isApproved: venues[index].isApproved,
                //navigate to venue details
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdminApprovedVenueDetails(
                      adminApproveCubit: widget.adminApproveCubit,
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
          widget.adminApproveCubit.showAdminActionsDialog(
            context,
            text: 'Suspending the venue please wait...',
            animation: 'assets/animations/ban.json',
            color: GColors.suspendColor,
          );
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
