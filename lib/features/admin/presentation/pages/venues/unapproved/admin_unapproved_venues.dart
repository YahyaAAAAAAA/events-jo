import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/components/no_requests_left.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20unapprove/admin_unapprove_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapprovedVenues extends StatefulWidget {
  final AdminUnapproveCubit adminUnapproveCubit;
  final TabController tabController;

  const AdminUnapprovedVenues({
    super.key,
    required this.adminUnapproveCubit,
    required this.tabController,
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
                    builder: (context) => AdminUnapprovedVenueDetails(
                      adminUnapproveCubit: widget.adminUnapproveCubit,
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
        if (state is AdminUnapproveError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const GlobalLoadingAdminBar();
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminUnapproveError) {
          GSnackBar.show(context: context, text: state.message);
        }

        //approval loading dialog
        if (state is AdminApproveActionLoading) {
          widget.adminUnapproveCubit.showAdminActionsDialog(context,
              text: 'Approving the venue please wait...', icon: Icons.check);
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
          widget.adminUnapproveCubit.showAdminActionsDialog(context,
              text: 'Denying the venue please wait...', icon: Icons.clear);
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
