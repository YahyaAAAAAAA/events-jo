import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_sub_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/approved%20venues/admin_approved_venue_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_cubit.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApprovedVenueDetailsPage extends StatefulWidget {
  final WeddingVenue weddingVenue;
  final AdminApproveCubit adminApproveCubit;

  const AdminApprovedVenueDetailsPage({
    super.key,
    required this.weddingVenue,
    required this.adminApproveCubit,
  });

  @override
  State<AdminApprovedVenueDetailsPage> createState() =>
      _AdminApprovedVenueDetailsPageState();
}

class _AdminApprovedVenueDetailsPageState
    extends State<AdminApprovedVenueDetailsPage> {
  late final WeddingVenue weddingVenue;
  late final AdminSingleVenueCubit adminSingleVenueCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  @override
  void initState() {
    super.initState();

    weddingVenue = widget.weddingVenue;

    //cubit
    adminSingleVenueCubit = context.read<AdminSingleVenueCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: weddingVenue.latitude,
      long: weddingVenue.longitude,
      initLat: weddingVenue.latitude,
      initLong: weddingVenue.longitude,
    );

    //lock venue
    widget.adminApproveCubit.lockVenue(weddingVenue.id);
    //get stream for venue
    adminSingleVenueCubit.getVenueStream(weddingVenue.id);
  }

  @override
  void dispose() {
    super.dispose();
    //unlock venue
    widget.adminApproveCubit.unlockVenue(weddingVenue.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminSubAppBar(),
      body: BlocConsumer<AdminSingleVenueCubit, AdminSingleVenueStates>(
        builder: (context, state) {
          if (state is AdminSingleVenueLoaded) {
            //get state data
            final venue = state.data.venue;
            final meals = state.data.meals;
            final drinks = state.data.drinks;

            return AdminApprovedVenueSummary(
              venueName: venue.name,
              peopleMax: venue.peopleMax,
              peopleMin: venue.peopleMin,
              peoplePrice: venue.peoplePrice,
              ownerName: venue.ownerName,
              onSuspendPressed: () async {
                await widget.adminApproveCubit.suspendVenue(venue.id);
                Navigator.of(context).pop();
              },
              //todo should update location object
              showMap: () => locationCubit.showMapDialogPreview(
                context,
                userLocation: userLocation,
                gradient: GColors.adminGradient,
              ),
              showMeals: () => widget.adminApproveCubit
                  .showMealsDialogPreview(context, meals),
              showDrinks: () => widget.adminApproveCubit
                  .showDrinksDialogPreview(context, drinks),
              showImages: () => widget.adminApproveCubit
                  .showImagesDialogPreview(context, venue.pics),
              showLicense: () => widget.adminApproveCubit
                  .showImagesDialogPreview(
                      context, ['https://i.ibb.co/bb3jstn/license.jpg']),
              range: DateTimeRange(
                start: DateTime(
                  venue.startDate[0],
                  venue.startDate[1],
                  venue.startDate[2],
                ),
                end: DateTime(
                  venue.endDate[0],
                  venue.endDate[1],
                  venue.endDate[2],
                ),
              ),
              time: [
                venue.time[0],
                venue.time[1],
              ],
            );
          }
          //error
          if (state is AdminSingleVenueError) {
            return Text(state.messege);
          }
          //loading...
          return const GlobalLoadingAdminBar(mainText: false);
        },
        listener: (context, state) {
          //change
          if (state is AdminSingleVenueChanged) {
            GSnackBar.show(
              context: context,
              text: state.change,
              color: GColors.cyanShade6,
              gradient: GColors.adminGradient,
            );
          }

          //error
          if (state is AdminSingleVenueError) {
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
