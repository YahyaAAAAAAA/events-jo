import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venue_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedVenuesPage extends StatefulWidget {
  const AdminApprovedVenuesPage({
    super.key,
  });

  @override
  State<AdminApprovedVenuesPage> createState() =>
      _AdminApprovedVenuesPageState();
}

class _AdminApprovedVenuesPageState extends State<AdminApprovedVenuesPage> {
  late final AdminApproveCubit adminApproveCubit;

  @override
  void initState() {
    super.initState();

    adminApproveCubit = context.read<AdminApproveCubit>();

    //start listening to approved venues stream
    adminApproveCubit.getApprovedWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminApproveCubit, AdminApproveStates>(
      builder: (context, state) {
        //done
        if (state is AdminApproveLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return const EmptyList(
              icon: CustomIcons.sad,
              text: 'No Approved Venues in EventsJo',
            );
          }

          return ListView.builder(
            itemCount: venues.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AdminEventsCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                isApproved: venues[index].isApproved,
                isBeingApproved: venues[index].isBeingApproved,
                isLoading: false,
                //navigate to venue details
                onPressed: () => context.push(
                  AdminApprovedVenueDetailsPage(
                    adminApproveCubit: adminApproveCubit,
                    weddingVenue: venues[index],
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
          return const AdminEventListLoadingCard();
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminApproveError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
        //approval loading dialog
        if (state is AdminSuspendActionLoading) {
          adminApproveCubit.showAdminActionsDialog(
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
            gradient: GColors.adminGradient,
          );
        }
      },
    );
  }
}
