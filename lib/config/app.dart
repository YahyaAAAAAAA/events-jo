import 'package:events_jo/config/enums/user%20type/user_type_gate.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/data/firebase_admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/auth/data/firebase_auth_repo.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:events_jo/features/auth/representation/pages/auth_page.dart';
import 'package:events_jo/features/location/data/geolocator_location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
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
        //approved venues cubit
        BlocProvider(
          create: (context) => AdminApproveCubit(adminRepo: adminRepo),
        ),
        //unapproved venues cubit
        BlocProvider(
          create: (context) => AdminUnapproveCubit(adminRepo: adminRepo),
        ),
        //users count cubit
        BlocProvider(
          create: (context) => AdminUsersCountCubit(adminRepo: adminRepo),
        ),
        //owners count cubit
        BlocProvider(
          create: (context) => AdminOwnersCountCubit(adminRepo: adminRepo),
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
              //user authenticated now check type (user,owner,admin)
              return const UserTypeGate();
            } else {
              return const Scaffold(
                body: Center(
                  child: GlobalLoadingBar(),
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
