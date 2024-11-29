import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/data/firebase_admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin_cubit.dart';
import 'package:events_jo/features/auth/data/firebase_auth_repo.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:events_jo/features/auth/representation/pages/auth_page.dart';
import 'package:events_jo/features/location/data/geolocator_location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/navigation/presentation/navigation_bar.dart';
import 'package:events_jo/features/owner/data/firebase_owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_cubit.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_drinks_repo.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_meals_repo.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/wedding_venue_cubit.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Root level

repos for the database
  -firebase

bloc providers 
  -auth
  ...

auth state
  -unauthenticated -> auth page (login/register)
  -authenticated -> home page

*/

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final weddingVenueRepo = FirebaseWeddingVenueRepo();
  final weddingVenueMealsRepo = FirebaseWeddingVenueMealsRepo();
  final weddingVenueDrinksRepo = FirebaseWeddingVenueDrinksRepo();
  final locationRepo = GeolocatorLocationRepo();
  final ownerRepo = FirebaseOwnerRepo();
  final adminRepo = FirebaseAdminRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        //location cubit
        BlocProvider(
          create: (context) => LocationCubit(locationRepo: locationRepo),
        ),
        //wedding venue cubit
        BlocProvider(
          create: (context) =>
              WeddingVenueCubit(weddingVenueRepo: weddingVenueRepo),
        ),
        //wedding venue meals cubit
        BlocProvider(
          create: (context) => WeddingVenueMealsCubit(
            weddingVenueMealsRepo: weddingVenueMealsRepo,
          ),
        ),
        //wedding venue drinks cubit
        BlocProvider(
          create: (context) => WeddingVenueDrinksCubit(
            weddingVenueDrinksRepo: weddingVenueDrinksRepo,
          ),
        ),
        //owner cubit
        BlocProvider(
          create: (context) => OwnerCubit(ownerRepo: ownerRepo),
        ),
        //admin cubit
        BlocProvider(
          create: (context) => AdminCubit(adminRepo: adminRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Abel',
          scaffoldBackgroundColor: GColors.scaffoldBg,
          appBarTheme: AppBarTheme(
            backgroundColor: GColors.appBarBg,
            iconTheme: IconThemeData(
              color: GColors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: GColors.whiteShade3,
          ),
        ),
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, authState) {
            debugPrint(authState.toString());

            if (authState is Unauthenticated) {
              return const AuthPage();
            }
            if (authState is Authenticated) {
              return const GlobalNavigationBar();
            } else {
              return const Scaffold(
                body: Center(
                  child: LoadingIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              GSnackBar.show(context: context, text: state.message);
            }
          },
        ),
      ),
    );
  }
}
