import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/unapproved%20courts/admin_unapproved_court_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/unapproved/admin_unapproved_courts_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20court/admin_single_court_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20court/admin_single_court_states.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapprovedCourtDetailsPage extends StatefulWidget {
  final FootballCourt footballCourt;
  final AdminUnapprovedCourtsCubit adminUnapprovedCourtsCubit;

  const AdminUnapprovedCourtDetailsPage({
    super.key,
    required this.footballCourt,
    required this.adminUnapprovedCourtsCubit,
  });

  @override
  State<AdminUnapprovedCourtDetailsPage> createState() =>
      _AdminUnapprovedCourtDetailsPageState();
}

class _AdminUnapprovedCourtDetailsPageState
    extends State<AdminUnapprovedCourtDetailsPage> {
  late final FootballCourt footballCourt;

  //cubits
  late final AdminSingleCourtCubit adminSingleCourtCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  @override
  void initState() {
    super.initState();

    footballCourt = widget.footballCourt;

    //cubit
    adminSingleCourtCubit = context.read<AdminSingleCourtCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: footballCourt.latitude,
      long: footballCourt.longitude,
      initLat: footballCourt.latitude,
      initLong: footballCourt.longitude,
    );

    //lock venue
    widget.adminUnapprovedCourtsCubit.lockCourt(footballCourt.id);
    //get stream
    adminSingleCourtCubit.getCourtStream(footballCourt.id);
  }

  @override
  void dispose() {
    super.dispose();

    //unlock venue
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        //team: without this delay for some reason the approved venue appears
        //in the venues page and then disappears (delay solves it)
        await Delay.twoSeconds();

        widget.adminUnapprovedCourtsCubit.unlockCourt(footballCourt.id);
      },
    );
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

            return UnapprovedAdminCourtSummary(
              courtName: court.name,
              peoplePrice: court.pricePerHour,
              ownerName: court.ownerName,
              showImages: () => widget.adminUnapprovedCourtsCubit
                  .showImagesDialogPreview(context, court.pics),
              showLicense: () => widget.adminUnapprovedCourtsCubit
                  .showImagesDialogPreview(
                      context, ['https://i.ibb.co/bb3jstn/license.jpg']),
              onApprovePressed: () async {
                //approve action
                await widget.adminUnapprovedCourtsCubit.approveCourt(court.id);

                Navigator.of(context).pop();
              },
              onDenyPressed: () async {
                //admin denying, don't notify
                adminSingleCourtCubit.isDenying = true;

                //deny action
                await widget.adminUnapprovedCourtsCubit
                    .denyCourt(court.id, court.pics);

                //admin done denying
                adminSingleCourtCubit.isDenying = false;

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
