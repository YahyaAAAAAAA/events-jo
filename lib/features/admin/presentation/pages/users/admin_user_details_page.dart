import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/admin_sub_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/users/admin_user_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AdminUserDetailsPage extends StatefulWidget {
  final AppUser user;

  const AdminUserDetailsPage({
    super.key,
    required this.user,
  });

  @override
  State<AdminUserDetailsPage> createState() => _AdminUserDetailsPageState();
}

class _AdminUserDetailsPageState extends State<AdminUserDetailsPage> {
  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final MapLocation userLocation;

  //user stream
  late final AdminSingleUserCubit adminSingleOwnerCubit;

  //venue meals cubit & list
  late final WeddingVenueMealsCubit weddingVenueMealsCubit;
  late List<WeddingVenueMeal> meals = [];

  //venue meals cubit & list
  late final WeddingVenueDrinksCubit weddingVenueDrinksCubit;
  late List<WeddingVenueDrink> drinks = [];

  @override
  void initState() {
    super.initState();

    weddingVenueMealsCubit = context.read<WeddingVenueMealsCubit>();
    weddingVenueDrinksCubit = context.read<WeddingVenueDrinksCubit>();
    adminSingleOwnerCubit = context.read<AdminSingleUserCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = MapLocation(
      lat: widget.user.latitude,
      long: widget.user.longitude,
      initLat: widget.user.latitude,
      initLong: widget.user.longitude,
      marker: Marker(
        point: LatLng(
          widget.user.latitude,
          widget.user.longitude,
        ),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );

    adminSingleOwnerCubit.getUserStream(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminSubAppBar(),
      body: BlocConsumer<AdminSingleUserCubit, AdminSingleUserStates>(
        builder: (context, state) {
          if (state is AdminSingleUserLoaded) {
            return AdminUserSummary(
              name: state.user!.name,
              email: state.user!.email,
              id: state.user!.uid,
              //todo should update location object
              showMap: () => locationCubit.showMapDialogPreview(context,
                  userLocation: userLocation, gradient: GColors.adminGradient),
            );
          }
          //error
          if (state is AdminSingleUserError) {
            return Text(state.messege);
          }
          //loading...
          return const GlobalLoadingAdminBar(mainText: false);
        },
        listener: (context, state) {
          //change
          if (state is AdminSingleUserChanged) {
            GSnackBar.show(
              context: context,
              text: 'A change has occurred',
              color: GColors.cyanShade6,
            );
          }

          //error
          if (state is AdminSingleUserError) {
            GSnackBar.show(context: context, text: state.messege);
          }
        },
      ),
    );
  }
}
