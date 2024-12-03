import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_sub_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/unapproved%20venues/admin_unapproved_venue_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AdminUnapprovedVenueDetails extends StatefulWidget {
  final WeddingVenue weddingVenue;
  final AdminUnapproveCubit adminUnapproveCubit;

  const AdminUnapprovedVenueDetails({
    super.key,
    required this.weddingVenue,
    required this.adminUnapproveCubit,
  });

  @override
  State<AdminUnapprovedVenueDetails> createState() =>
      _AdminUnapprovedVenueDetailsState();
}

class _AdminUnapprovedVenueDetailsState
    extends State<AdminUnapprovedVenueDetails> {
  late final WeddingVenue weddingVenue;

  //cubits
  late final AdminSingleVenueCubit adminSingleVenueCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final MapLocation userLocation;

  //venue meals cubit & list
  late final WeddingVenueMealsCubit weddingVenueMealsCubit;
  late List<WeddingVenueMeal> meals = [];

  //venue meals cubit & list
  late final WeddingVenueDrinksCubit weddingVenueDrinksCubit;
  late List<WeddingVenueDrink> drinks = [];

  @override
  void initState() {
    super.initState();

    weddingVenue = widget.weddingVenue;

    //cubits
    weddingVenueMealsCubit = context.read<WeddingVenueMealsCubit>();
    weddingVenueDrinksCubit = context.read<WeddingVenueDrinksCubit>();
    adminSingleVenueCubit = context.read<AdminSingleVenueCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = MapLocation(
      lat: weddingVenue.latitude,
      long: weddingVenue.longitude,
      initLat: weddingVenue.latitude,
      initLong: weddingVenue.longitude,
      marker: Marker(
        point: LatLng(
          weddingVenue.latitude,
          weddingVenue.longitude,
        ),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );

    adminSingleVenueCubit.getVenueStream(weddingVenue.id);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get meals list
        meals = await weddingVenueMealsCubit.getAllMeals(weddingVenue.id);

        //get drinks list
        drinks = await weddingVenueDrinksCubit.getAllDrinks(weddingVenue.id);

        //initialize meals & drinks price
        for (int i = 0; i < meals.length; i++) {
          meals[i].calculatedPrice = meals[i].price;
        }

        for (int i = 0; i < drinks.length; i++) {
          drinks[i].calculatedPrice = drinks[i].price;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminSubAppBar(),
      body: BlocConsumer<AdminSingleVenueCubit, AdminSingleVenueStates>(
        builder: (context, state) {
          if (state is AdminSingleVenueLoaded) {
            //get state venue
            final venue = state.venue!;
            return UnapprovedAdminVenueSummary(
              venueName: venue.name,
              peopleMax: venue.peopleMax,
              peopleMin: venue.peopleMin,
              peoplePrice: venue.peoplePrice,
              ownerName: venue.ownerName,
              onApprovePressed: () async {
                await widget.adminUnapproveCubit.approveVenue(venue.id);
                Navigator.of(context).pop();
              },
              onDenyPressed: () async {
                await widget.adminUnapproveCubit
                    .denyVenue(venue.id, venue.pics);
                Navigator.of(context).pop();
              },
              //todo should update location object
              showMap: () => locationCubit.showMapDialogPreview(
                context,
                userLocation: userLocation,
                gradient: GColors.adminGradient,
              ),
              showMeals: () => widget.adminUnapproveCubit
                  .showMealsDialogPreview(context, meals),
              showDrinks: () => widget.adminUnapproveCubit
                  .showDrinksDialogPreview(context, drinks),
              showImages: () => widget.adminUnapproveCubit
                  .showImagesDialogPreview(context, venue.pics),
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
          return const GlobalLoadingAdminBar();
        },
        listener: (context, state) {
          //change
          if (state is AdminSingleVenueChanged) {
            GSnackBar.show(
              context: context,
              text: 'A change has occurred',
              color: GColors.cyanShade6,
            );
          }

          //error
          if (state is AdminSingleVenueError) {
            GSnackBar.show(context: context, text: state.messege);
          }
        },
      ),
    );
  }
}
