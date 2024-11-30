import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/approved%20venues/admin_approved_venue_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
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

class AdminApprovedVenueDetails extends StatefulWidget {
  final WeddingVenue weddingVenue;
  final AdminApproveCubit adminApproveCubit;

  const AdminApprovedVenueDetails({
    super.key,
    required this.weddingVenue,
    required this.adminApproveCubit,
  });

  @override
  State<AdminApprovedVenueDetails> createState() =>
      _AdminApprovedVenueDetailsState();
}

class _AdminApprovedVenueDetailsState extends State<AdminApprovedVenueDetails> {
  late final WeddingVenue weddingVenue;
  late final AdminApproveCubit adminApproveCubit;

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

    adminApproveCubit = widget.adminApproveCubit;

    weddingVenueMealsCubit = context.read<WeddingVenueMealsCubit>();
    weddingVenueDrinksCubit = context.read<WeddingVenueDrinksCubit>();

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
      appBar: AppBar(
        leading: AppBarButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icons.arrow_back_ios_new,
          size: 25,
        ),
        leadingWidth: 90,
        toolbarHeight: 70,
      ),
      body: AdminApprovedVenueSummary(
        venueName: weddingVenue.name,
        peopleMax: weddingVenue.peopleMax,
        peopleMin: weddingVenue.peopleMin,
        peoplePrice: weddingVenue.peoplePrice,
        ownerName: weddingVenue.ownerName,
        onSuspendPressed: () async {
          await adminApproveCubit.suspendVenue(weddingVenue.id);
          Navigator.of(context).pop();
        },
        showMap: () => locationCubit.showMapDialogPreview(context,
            userLocation: userLocation),
        showMeals: () =>
            adminApproveCubit.showMealsDialogPreview(context, meals),
        showDrinks: () =>
            adminApproveCubit.showDrinksDialogPreview(context, drinks),
        showImages: () => adminApproveCubit.showImagesDialogPreview(
            context, weddingVenue.pics),
        range: DateTimeRange(
          start: DateTime(
            weddingVenue.startDate[0],
            weddingVenue.startDate[1],
            weddingVenue.startDate[2],
          ),
          end: DateTime(
            weddingVenue.endDate[0],
            weddingVenue.endDate[1],
            weddingVenue.endDate[2],
          ),
        ),
        time: [
          weddingVenue.time[0],
          weddingVenue.time[1],
        ],
      ),
    );
  }
}
