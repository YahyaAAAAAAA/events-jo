import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/approved%20courts/admin_approved_court_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20court/admin_single_court_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20court/admin_single_court_states.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedCourtDetailsPage extends StatefulWidget {
  final FootballCourt footballCourt;
  final AdminApprovedCourtsCubit adminApprovedCourtsCubit;

  const AdminApprovedCourtDetailsPage({
    super.key,
    required this.footballCourt,
    required this.adminApprovedCourtsCubit,
  });

  @override
  State<AdminApprovedCourtDetailsPage> createState() =>
      _AdminApprovedCourtDetailsPageState();
}

class _AdminApprovedCourtDetailsPageState
    extends State<AdminApprovedCourtDetailsPage> {
  late final FootballCourt fooballCourt;
  late final AdminSingleCourtCubit adminSingleCourteCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  @override
  void initState() {
    super.initState();

    fooballCourt = widget.footballCourt;

    //cubit
    adminSingleCourteCubit = context.read<AdminSingleCourtCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: fooballCourt.latitude,
      long: fooballCourt.longitude,
      initLat: fooballCourt.latitude,
      initLong: fooballCourt.longitude,
    );

    //lock venue
    widget.adminApprovedCourtsCubit.lockCourt(fooballCourt.id);
    //get stream for venue
    adminSingleCourteCubit.getCourtStream(fooballCourt.id);
  }

  @override
  void dispose() {
    super.dispose();
    //unlock venue
    widget.adminApprovedCourtsCubit.unlockCourt(fooballCourt.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Court Info',
      ),
      body: BlocConsumer<AdminSingleCourtCubit, AdminSingleCourtStates>(
        builder: (context, state) {
          if (state is AdminSingleCourtLoaded) {
            //get state data
            final court = state.court;

            return AdminApprovedCourtSummary(
              courtName: court.name,
              peoplePrice: court.pricePerHour,
              ownerName: court.ownerName,
              showImages: () => widget.adminApprovedCourtsCubit
                  .showImagesDialogPreview(context, court.pics),
              showLicense: () => widget.adminApprovedCourtsCubit
                  .showImagesDialogPreview(
                      context, ['https://i.ibb.co/bb3jstn/license.jpg']),
              onSuspendPressed: () async {
                await widget.adminApprovedCourtsCubit.suspendCourt(court.id);
                Navigator.of(context).pop();
              },
              //todo should update location object
              showMap: () => locationCubit.showMapDialogPreview(
                context,
                userLocation: userLocation,
                gradient: GColors.adminGradient,
              ),
              time: [
                court.time[0],
                court.time[1],
              ],
            );
          }

          //loading...
          return const GlobalLoadingAdminBar(mainText: false);
        },
        listener: (context, state) {
          //error
          if (state is AdminSingleCourtError) {
            GSnackBar.show(
              context: context,
              text: state.messege,
              gradient: GColors.adminGradient,
            );
          }
        },
      ),
    );
  }
}
