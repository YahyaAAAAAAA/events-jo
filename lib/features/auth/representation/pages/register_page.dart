import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/representation/components/change_user_type_row.dart';
import 'package:events_jo/features/auth/representation/components/events_jo_logo_auth.dart';
import 'package:events_jo/features/location/representation/components/location_loading_dialog.dart';
import 'package:events_jo/features/location/representation/components/location_provided_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:events_jo/features/location/representation/components/map_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();
  late final LocationCubit locationCubit;
  Position? location;

  //determine which account to create (user or owner)
  bool isOwner = false;

  //users coords
  double lat = 0;
  double long = 0;
  //init location incase the user cancel
  double initLat = 0;
  double initLong = 0;

  //empty marker for now
  late Marker marker;

  @override
  void initState() {
    super.initState();

    locationCubit = context.read<LocationCubit>();

    marker = Marker(
      point: LatLng(lat, long),
      child: Icon(
        Icons.location_pin,
        color: GColors.black,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    locationCubit.emit(LocationInitial());
  }

  //some checks then proceeds with user registration
  void register() {
    //prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;
    final String name = nameController.text;

    //cubit
    final authCubit = context.read<AuthCubit>();

    //location doesn't exist
    if (lat == 0 || long == 0) {
      GSnackBar.show(
        context: context,
        text: 'Please provide your location',
      );

      return;
    }

    if (email.isNotEmpty &&
        pw.isNotEmpty &&
        name.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.regitser(
          name,
          email,
          pw,
          lat,
          long,
          isOwner,
        );
      } else {
        GSnackBar.show(
          context: context,
          text: 'Passwords dont match',
        );
      }
    } else {
      GSnackBar.show(
        context: context,
        text: 'Please enter both email and password',
      );
    }
  }

  //shows map to change location
  Future<Object?> showMapDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => StatefulBuilder(
        builder: (context, setState) => MapDialog(
          latitude: lat,
          longitude: long,
          marker: marker,
          onTap: (tapPoint, point) {
            setState(() {
              //update coords
              lat = point.latitude;
              long = point.longitude;

              //update marker
              marker = Marker(
                point: point,
                child: Icon(
                  Icons.location_pin,
                  color: GColors.black,
                ),
              );
            });
          },
          //bring coords and marker to init value
          onCancel: () {
            Navigator.of(context).pop();
            setState(
              () {
                lat = initLat;
                long = initLong;
                marker = Marker(
                  point: LatLng(lat, long),
                  child: Icon(
                    Icons.location_pin,
                    color: GColors.black,
                  ),
                );
              },
            );
          },
          //saves coords and marker new values
          onConfirm: () {
            setState(
              () {
                Navigator.of(context).pop();
                initLat = lat;
                initLong = long;
                marker = Marker(
                  point: LatLng(lat, long),
                  child: Icon(
                    Icons.location_pin,
                    color: GColors.black,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EventsJoLogoAuth(),

                  //welcome back message
                  FittedBox(
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  ChangeUserTypeRow(
                    setUserType: () => setState(() => isOwner = false),
                    setOwnerType: () => setState(() => isOwner = true),
                    isOwner: isOwner,
                  ),

                  const SizedBox(height: 25),

                  //name textField
                  AuthTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //email textField
                  AuthTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //pw textField
                  AuthTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  AuthTextField(
                    controller: confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  //location bloc
                  BlocConsumer<LocationCubit, LocationStates>(
                    builder: (context, state) {
                      //location not provided
                      if (state is LocationInitial) {
                        return AuthButton(
                          onTap: () async {
                            //get location from cubit
                            location = await locationCubit.getUserLocation();

                            //save location
                            lat = location!.latitude;
                            long = location!.longitude;

                            //save initial location
                            initLat = location!.latitude;
                            initLong = location!.longitude;

                            //set marker to user location
                            marker = Marker(
                              point: LatLng(
                                lat,
                                long,
                              ),
                              child: Icon(
                                Icons.location_pin,
                                color: GColors.black,
                              ),
                            );
                          },
                          text: 'Provide your location',
                          icon: Icons.location_on_outlined,
                        );
                      }

                      //location provided
                      if (state is LocationLoaded) {
                        //* allow user to change location
                        return LocationProvided(
                          onPressed: () => showMapDialog(context),
                        );
                      }

                      //loading...
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: GColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingIndicator(withImage: false),
                          ],
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is LocationLoading) {
                        LocationLoadingDialog.showLocationLoadingDialog(
                            context);
                      }
                      if (state is LocationLoaded) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),

                  const SizedBox(height: 25),

                  //register button
                  AuthButton(
                    onTap: register,
                    text: 'Register',
                    icon: Icons.arrow_forward_ios,
                  ),

                  const SizedBox(height: 50),

                  //not a member ? register now
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'You have an accout ? ',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login now!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GColors.royalBlue,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
