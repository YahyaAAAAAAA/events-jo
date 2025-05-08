import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_states.dart';
import 'package:events_jo/features/admin/presentation/pages/courts/approved/admin_approved_courts_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedCourtsPage extends StatefulWidget {
  const AdminApprovedCourtsPage({
    super.key,
  });

  @override
  State<AdminApprovedCourtsPage> createState() =>
      _AdminApprovedCourtsPageState();
}

class _AdminApprovedCourtsPageState extends State<AdminApprovedCourtsPage> {
  late final AdminApprovedCourtsCubit adminApprovedCourtsCubit;

  @override
  void initState() {
    super.initState();

    adminApprovedCourtsCubit = context.read<AdminApprovedCourtsCubit>();

    //start listening to approved venues stream
    adminApprovedCourtsCubit.getApprovedCourtStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminApprovedCourtsCubit, AdminApprovedCourtsStates>(
      builder: (context, state) {
        //done
        if (state is AdminApprovedCourtsLoaded) {
          final courts = state.courts;

          if (courts.isEmpty) {
            return const EmptyList(
              icon: CustomIcons.sad,
              text: 'No Approved Courts in EventsJo',
            );
          }

          return ListView.builder(
            itemCount: courts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AdminEventsCard(
                name: courts[index].name,
                owner: courts[index].ownerName,
                index: index,
                isApproved: courts[index].isApproved,
                isBeingApproved: courts[index].isBeingApproved,
                isLoading: false,
                icon: CustomIcons.football,
                //navigate to venue details
                onPressed: () => courts[index].isBeingApproved
                    ? context
                        .showSnackBar('Court is being approved by other admin')
                    : context.push(
                        AdminApprovedCourtDetailsPage(
                          adminApprovedCourtsCubit: adminApprovedCourtsCubit,
                          footballCourt: courts[index],
                        ),
                      ),
              );
            },
          );
        }

        //loading...
        else {
          return const AdminEventListLoadingCard();
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminApprovedCourtsError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
        //approval loading dialog
        if (state is AdminApprovedCourtsSuspendActionLoading) {
          adminApprovedCourtsCubit.showAdminActionsDialog(
            context,
            text: 'Suspending the court please wait...',
            animation: 'assets/animations/ban.json',
            color: GColors.suspendColor,
          );
        }
        if (state is AdminApprovedCourtsSuspendActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Court Suspended Successfully',
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
      },
    );
  }
}
