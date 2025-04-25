import 'package:events_jo/config/theme/eventsjo_theme.dart';
import 'package:events_jo/features/auth/representation/pages/user_type_gate.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/data/firebase_admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20owner/admin_single_owner_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approved/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_cubit.dart';
import 'package:events_jo/features/auth/data/firebase_auth_repo.dart';
import 'package:events_jo/features/auth/representation/components/auth_error_card.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:events_jo/features/auth/representation/pages/auth_page.dart';
import 'package:events_jo/features/chat/data/firebase_chat_repo.dart';
import 'package:events_jo/features/chat/representation/cubits/chat/chat_cubit.dart';
import 'package:events_jo/features/chat/representation/cubits/message/message_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/single%20court/single_football_court_cubit.dart';
import 'package:events_jo/features/events/shared/data/firebase_events_repo.dart';
import 'package:events_jo/features/location/data/geolocator_location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/order/data/firebase_order_repo.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/owner/data/firebase_owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/courts/owner_courts_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_cubit.dart';
import 'package:events_jo/features/settings/data/firebase_settings_repo.dart';
import 'package:events_jo/features/settings/representation/cubits/email/email_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/password/password_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/single%20venue/single_wedding_venue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class EventsJoApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final locationRepo = GeolocatorLocationRepo();
  final ownerRepo = FirebaseOwnerRepo();
  final adminRepo = FirebaseAdminRepo();
  final settingsRepo = FirebaseSettingsRepo();
  final orderRepo = FirebaseOrderRepo();
  final eventsRepo = FirebaseEventsRepo();
  final chatRepo = FirebaseChatRepo();

  EventsJoApp({super.key});

  @override
  Widget build(BuildContext context) {
    //remove splash screen
    FlutterNativeSplash.remove();

    //set orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

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
          create: (context) => WeddingVenuesCubit(eventsRepo: eventsRepo),
        ),
        //single wedding venue cubit
        BlocProvider(
          create: (context) => SingleWeddingVenueCubit(eventsRepo: eventsRepo),
        ),
        //football court cubit
        BlocProvider(
          create: (context) => FootballCourtsCubit(eventsRepo: eventsRepo),
        ),
        //single football court cubit
        BlocProvider(
          create: (context) => SingleFootballCourtCubit(eventsRepo: eventsRepo),
        ),
        //owner cubit
        BlocProvider(
          create: (context) => OwnerCubit(ownerRepo: ownerRepo),
        ),
        //owner venues cubit
        BlocProvider(
          create: (context) => OwnerVenuesCubit(ownerRepo: ownerRepo),
        ),
        //settings cubit
        BlocProvider(
          create: (context) => SettingsCubit(settingsRepo: settingsRepo),
        ),
        //email cubit
        BlocProvider(
          create: (context) => EmailCubit(settingsRepo: settingsRepo),
        ),
        //password cubit
        BlocProvider(
          create: (context) => PasswordCubit(settingsRepo: settingsRepo),
        ),
        //order cubit
        BlocProvider(
          create: (context) => OrderCubit(orderRepo: orderRepo),
        ),
        //message cubit
        BlocProvider(
          create: (context) => MessageCubit(chatRepo: chatRepo),
        ),
        //chat cubit
        BlocProvider(
          create: (context) => ChatCubit(chatRepo: chatRepo),
        ),
        //----
        BlocProvider(
          create: (context) => OwnerCourtsCubit(ownerRepo: ownerRepo),
        ),
        //* -------------------Admin cubits below-------------------
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
        //users online cubit
        BlocProvider(
          create: (context) => AdminUsersOnlineCubit(adminRepo: adminRepo),
        ),
        //owners online cubit
        BlocProvider(
          create: (context) => AdminOwnersOnlineCubit(adminRepo: adminRepo),
        ),
        //single user cubit
        BlocProvider(
          create: (context) => AdminSingleUserCubit(adminRepo: adminRepo),
        ),
        //single owner cubit
        BlocProvider(
          create: (context) => AdminSingleOwnerCubit(adminRepo: adminRepo),
        ),
        //single venue cubit
        BlocProvider(
          create: (context) => AdminSingleVenueCubit(adminRepo: adminRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: eventsJoTheme(),
        home: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: BlocConsumer<AuthCubit, AuthStates>(
            builder: (context, state) {
              debugPrint(state.toString());

              //not logged-in
              if (state is Unauthenticated) {
                return const AuthPage();
              }

              //logged-in
              if (state is Authenticated) {
                //user authenticated now check type (user,owner,admin)
                return const UserTypeGate();
              }

              //loading...
              if (state is AuthLoading) {
                return Scaffold(
                  body: GlobalLoadingBar(
                    subText: state.message,
                  ),
                );
              }

              //error
              else {
                return const AuthErrorCard();
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                GSnackBar.show(context: context, text: state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
