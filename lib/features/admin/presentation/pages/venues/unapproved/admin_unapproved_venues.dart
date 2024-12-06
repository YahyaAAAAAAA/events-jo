import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/no_requests_left.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapprovedVenues extends StatefulWidget {
  final AdminUnapproveCubit adminUnapproveCubit;

  const AdminUnapprovedVenues({
    super.key,
    required this.adminUnapproveCubit,
  });

  @override
  State<AdminUnapprovedVenues> createState() => _AdminUnapprovedVenuesState();
}

class _AdminUnapprovedVenuesState extends State<AdminUnapprovedVenues> {
  @override
  void initState() {
    super.initState();

    //start listening to unapproved venues stream
    widget.adminUnapproveCubit.getUnapprovedWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUnapproveCubit, AdminUnapproveStates>(
      builder: (context, state) {
        //done
        if (state is AdminUnapproveLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return const NoRequestsLeft(
              icon: CustomIcons.grin_beam,
              text: 'No Requests for Wedding Venues left',
            );
          }

          return AnimatedListView(
            items: venues,
            shrinkWrap: true,
            enterTransition: [SlideInRight()],
            exitTransition: [SlideInRight()],
            insertDuration: const Duration(milliseconds: 300),
            removeDuration: const Duration(milliseconds: 300),
            isSameItem: (a, b) => a.id == b.id,
            itemBuilder: (context, index) {
              return AdminEventsCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                key: Key(widget.adminUnapproveCubit.generateUniqueId()),
                isApproved: venues[index].isApproved,
                isBeingApproved: venues[index].isBeingApproved,
                //navigate to venue details
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdminUnapprovedVenueDetails(
                      adminUnapproveCubit: widget.adminUnapproveCubit,
                      weddingVenue: venues[index],
                    ),
                  ),
                ),
              );
            },
          );
        }
        //error
        if (state is AdminUnapproveError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const GlobalLoadingAdminBar(mainText: false);
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminUnapproveError) {
          GSnackBar.show(context: context, text: state.message);
        }

        //approval loading dialog
        if (state is AdminApproveActionLoading) {
          widget.adminUnapproveCubit.showAdminActionsDialog(
            context,
            text: 'Approving the venue please wait...',
            animation: 'assets/animations/approve.json',
            color: GColors.approveColor,
          );
        }

        if (state is AdminApproveActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Venue Approved Successfully',
            color: GColors.cyanShade6,
          );
        }

        //denial loading dialog
        if (state is AdminDenyActionLoading) {
          widget.adminUnapproveCubit.showAdminActionsDialog(
            context,
            text: 'Denying the venue please wait...',
            animation: 'assets/animations/delete.json',
            color: GColors.denyColor,
          );
        }

        if (state is AdminDenyActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Venue Denyed Successfully',
            color: GColors.cyanShade6,
          );
        }
      },
    );
  }
}
