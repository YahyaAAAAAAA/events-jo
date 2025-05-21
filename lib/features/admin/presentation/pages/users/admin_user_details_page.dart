import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/users/admin_user_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final EjLocation userLocation;

  //user stream
  late final AdminSingleUserCubit adminSingleOwnerCubit;

  @override
  void initState() {
    super.initState();

    adminSingleOwnerCubit = context.read<AdminSingleUserCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: widget.user.latitude,
      long: widget.user.longitude,
      initLat: widget.user.latitude,
      initLong: widget.user.longitude,
    );

    adminSingleOwnerCubit.getUserStream(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'User Info',
      ),
      body: Center(
        child: BlocConsumer<AdminSingleUserCubit, AdminSingleUserStates>(
          builder: (context, state) {
            if (state is AdminSingleUserLoaded) {
              return AdminUserSummary(
                name: state.user!.name,
                email: state.user!.email,
                id: state.user!.uid,
                wasOwnerAndSwitched: state.user!.wasOwnerAndNowUser,
                //todo should update location object
                showMap: () => locationCubit.showMapDialogPreview(context,
                    userLocation: userLocation,
                    gradient: GColors.adminGradient),
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
                gradient: GColors.adminGradient,
              );
            }

            //error
            if (state is AdminSingleUserError) {
              GSnackBar.show(
                context: context,
                text: state.messege,
                gradient: GColors.adminGradient,
              );
            }
          },
        ),
      ),
    );
  }
}
