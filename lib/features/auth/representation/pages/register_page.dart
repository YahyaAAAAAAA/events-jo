import 'dart:math';

import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/representation/components/change_user_type_row.dart';
import 'package:events_jo/features/auth/representation/components/choose_location_method.dart';
import 'package:events_jo/features/auth/representation/components/events_jo_logo_auth.dart';
import 'package:events_jo/features/location/representation/components/location_loading_dialog.dart';
import 'package:events_jo/features/location/representation/components/location_provided_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//* This page allows user to make a new account (user or owner) to EventsJo
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
  //auth cubit
  late final AuthCubit authCubit;

  //text fields
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  //location
  late final LocationCubit locationCubit;
  late EjLocation userLocation;

  bool pwHideToggle = true;
  bool confirmPwHideToggle = true;

  //user type
  UserType type = UserType.user;

  @override
  void initState() {
    super.initState();

    //cubits
    authCubit = context.read<AuthCubit>();
    locationCubit = context.read<LocationCubit>();

    //prepare user location object
    userLocation = EjLocation(
      lat: 0,
      long: 0,
      initLat: 0,
      initLong: 0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            children: [
              const Center(
                child: EventsJoLogoAuth(),
              ),

              Text(
                "Create an account",
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10),

              ChangeUserTypeRow(
                onSelected: (value) {
                  //type is user
                  if (value == UserType.user) {
                    setState(() => type = UserType.user);
                  }
                  //type is owner
                  if (value == UserType.owner) {
                    setState(() => type = UserType.owner);
                  }
                },
                onRandomPress: () {
                  final random = Random();
                  final randomNumber = random.nextInt(900) + 100;
                  nameController.text = 'test$randomNumber';
                  emailController.text = 'test$randomNumber@gmail.com';
                  pwController.text = '123456';
                  confirmPwController.text = '123456';
                  setState(() {});
                },
                type: type,
              ),

              const SizedBox(height: 10),

              //name textField
              AuthTextField(
                controller: nameController,
                hintText: "Name",
                maxLength: 15,
              ),

              const SizedBox(height: 10),

              //email textField
              AuthTextField(
                controller: emailController,
                hintText: "Email",
              ),

              const SizedBox(height: 10),

              //pw textField
              AuthTextField(
                controller: pwController,
                hintText: "Password",
                obscureText: pwHideToggle,
                toggleObscure: () =>
                    setState(() => pwHideToggle = !pwHideToggle),
              ),

              const SizedBox(height: 10),

              AuthTextField(
                controller: confirmPwController,
                hintText: "Confirm Password",
                obscureText: confirmPwHideToggle,
                toggleObscure: () =>
                    setState(() => confirmPwHideToggle = !confirmPwHideToggle),
              ),

              const SizedBox(height: 10),

              //location bloc
              BlocConsumer<LocationCubit, LocationStates>(
                builder: (context, state) {
                  //no location for user

                  //location not provided
                  if (state is LocationInitial || state is LocationError) {
                    return AnimatedOpacity(
                      opacity: type == UserType.owner ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: type == UserType.owner ? true : false,
                        child: AuthButton(
                          onTap: () async => showDialog(
                            context: context,
                            builder: (context) {
                              return ChooseLocationMethod(
                                //pick location manually
                                onPressedManual: () async => await locationCubit
                                    .showMapDialogRegisterPage(
                                  context,
                                  userLocation: userLocation,
                                ),
                                //pick location automatically
                                onPressedAuto: () async {
                                  //pop the current dialog
                                  Navigator.of(context).pop();

                                  final location =
                                      await locationCubit.getUserLocation();

                                  if (location == null) {
                                    return;
                                  }

                                  //update location
                                  userLocation = EjLocation(
                                    lat: location.latitude,
                                    long: location.longitude,
                                    initLat: location.latitude,
                                    initLong: location.longitude,
                                  );
                                },
                              );
                            },
                          ),
                          text: 'Provide your location',
                          icon: Icons.location_on_outlined,
                        ),
                      ),
                    );
                  }

                  //location provided
                  if (state is LocationLoaded) {
                    //* allow user to change location
                    return LocationProvided(
                      onPressed: () => locationCubit.showMapDialog(
                        context,
                        userLocation: userLocation,
                      ),
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
                        GlobalLoadingBar(
                          mainText: false,
                        ),
                      ],
                    ),
                  );
                },
                listener: (context, state) {
                  //open loading dialog
                  if (state is LocationLoading) {
                    LocationLoadingDialog.show(context);
                  }

                  //close loading dialog
                  if (state is LocationLoaded) {
                    LocationLoadingDialog.close(context);
                  }

                  //error
                  if (state is LocationError) {
                    Navigator.of(context).pop();
                    GSnackBar.show(context: context, text: state.message);
                  }
                },
              ),

              const SizedBox(height: 25),

              //register button
              AuthButton(
                onTap: () async => await authCubit.regitser(
                  context,
                  email: emailController.text.trim(),
                  name: nameController.text.trim(),
                  pw: pwController.text,
                  confirmPw: confirmPwController.text,
                  latitude: type == UserType.owner ? userLocation.lat : 0,
                  longitude: type == UserType.owner ? userLocation.long : 0,
                  type: type,
                ),
                text: 'Register',
                icon: Icons.arrow_forward_ios,
              ),

              const SizedBox(height: 50),

              //not a member ? register now
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'You have an account ? ',
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
      resizeToAvoidBottomInset: false,
    );
  }
}
