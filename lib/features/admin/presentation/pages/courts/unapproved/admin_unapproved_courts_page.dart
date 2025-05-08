import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_states.dart';
import 'package:events_jo/features/admin/presentation/pages/courts/unapproved/admin_unapproved_courts_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapprovedCourtsPage extends StatefulWidget {
  const AdminUnapprovedCourtsPage({
    super.key,
  });

  @override
  State<AdminUnapprovedCourtsPage> createState() =>
      _AdminUnapprovedCourtsPageState();
}

class _AdminUnapprovedCourtsPageState extends State<AdminUnapprovedCourtsPage> {
  late final AdminUnapprovedCourtsCubit adminUnapprovedCourtsCubit;

  @override
  void initState() {
    super.initState();

    adminUnapprovedCourtsCubit = context.read<AdminUnapprovedCourtsCubit>();

    //start listening to unapproved venues stream
    adminUnapprovedCourtsCubit.getUnapprovedCourtsStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUnapprovedCourtsCubit,
        AdminUnapprovedCourtsStates>(
      builder: (context, state) {
        //done
        if (state is AdminUnapprovedCourtsLoaded) {
          final courts = state.courts;

          if (courts.isEmpty) {
            return const EmptyList(
              icon: CustomIcons.grin_beam,
              text: 'No Requests for Football Courts left',
            );
          }

          return ListView.builder(
            itemCount: courts.length,
            shrinkWrap: false,
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
                        AdminUnapprovedCourtDetailsPage(
                          adminUnapprovedCourtsCubit:
                              adminUnapprovedCourtsCubit,
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
        if (state is AdminUnapprovedCourtsError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            gradient: GColors.adminGradient,
          );
        }

        //approval loading dialog
        if (state is AdminUnapprovedCourtsApproveActionLoading) {
          adminUnapprovedCourtsCubit.showAdminActionsDialog(
            context,
            text: 'Approving the court please wait...',
            animation: 'assets/animations/approve.json',
            color: GColors.approveColor,
          );
        }

        if (state is AdminUnapprovedCourtsApproveActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Court approved successfully',
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }

        //denial loading dialog
        if (state is AdminUnapprovedCourtsDenyActionLoading) {
          adminUnapprovedCourtsCubit.showAdminActionsDialog(
            context,
            text: 'Denying the court please wait...',
            animation: 'assets/animations/delete.json',
            color: GColors.denyColor,
          );
        }

        if (state is AdminUnapprovedCourtsDenyActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Court denyed Successfully',
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
      },
    );
  }
}
