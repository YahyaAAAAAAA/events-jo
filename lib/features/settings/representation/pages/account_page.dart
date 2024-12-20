import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_dropdown_field.dart';
import 'package:events_jo/features/settings/representation/components/settings_icon_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  //todo make their own cubit
  final SettingsCubit settingsCubit;

  const AccountPage({
    super.key,
    required this.settingsCubit,
  });

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AppUser? user;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  String newName = '';
  UserType newType = UserType.user;
  UserType initType = UserType.user;

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;

    //get cubit
    locationCubit = context.read<LocationCubit>();

    //set initial values
    newName = user!.name;
    newType = user!.type;
    initType = user!.type;

    //setup user location values
    userLocation = EjLocation(
      lat: user!.latitude,
      long: user!.longitude,
      initLat: user!.latitude,
      initLong: user!.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Account Information',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: BlocConsumer<SettingsCubit, SettingsStates>(
            builder: (context, state) {
              //loading...
              if (state is SettingsLoading) {
                return const GlobalLoadingBar(
                  mainText: false,
                  subText: 'Updating Your Information',
                );
              }

              //loaded
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  //text
                  Text(
                    'Account Name',
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  //new name field
                  SettingsTextField(
                    hintText: 'New Name',
                    initialValue: user!.name,
                    //save new name
                    onChanged: (value) => newName = value,
                  ),

                  const SizedBox(height: 20),

                  //text
                  Text(
                    'Account Type',
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  //new type field
                  SettingsDropdownField(
                    type: user!.type,
                    onChanged: (newFieldType) {
                      if (newFieldType == null) {
                        return;
                      }
                      //save new type
                      newType = newFieldType;

                      //update
                      setState(() {});
                    },
                  ),

                  //text
                  newType != initType
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'You will be logged out after changing your account type',
                            style: TextStyle(
                              color: GColors.redShade3,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : const SizedBox(),

                  //text
                  newType != initType && initType == UserType.owner
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Your events will be deleted after changing your account type',
                            style: TextStyle(
                              color: GColors.redShade3,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox(),

                  const SizedBox(height: 20),

                  //change location button
                  newType == UserType.owner
                      ? Container(
                          decoration: BoxDecoration(
                            color: GColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: GColors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //change email text
                              Text(
                                'Your Location',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: GColors.royalBlue,
                                ),
                              ),

                              //change email button
                              Center(
                                child: SettingsIconButton(
                                  onPressed: () => locationCubit.showMapDialog(
                                    context,
                                    userLocation: userLocation,
                                  ),
                                  icon: Icons.location_on_outlined,
                                  padding: EdgeInsets.zero,
                                  buttonPadding: const EdgeInsets.all(20),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  const SizedBox(height: 30),

                  Center(
                    child: SettingsTextButton(
                      onPressed: () async {
                        //check if no changes
                        if (newName == user!.name &&
                            newType == initType &&
                            userLocation.lat == user!.latitude &&
                            userLocation.long == user!.longitude) {
                          GSnackBar.show(
                            context: context,
                            text: 'No changes have been made',
                          );
                          return;
                        }

                        //check if name changed
                        if (newName != user!.name) {
                          if (newName.trim().isEmpty) {
                            GSnackBar.show(
                              context: context,
                              text: 'Name cannot be empty',
                            );
                            return;
                          }
                          //update user name
                          await widget.settingsCubit.updateUserName(
                            newName.trim(),
                          );
                        }

                        //location changed
                        if ((userLocation.lat != user!.latitude) ||
                            (userLocation.long != user!.longitude)) {
                          await widget.settingsCubit.updateUserLocation(
                            user!.latitude,
                            user!.longitude,
                            userLocation.lat,
                            userLocation.long,
                          );
                        }

                        //check if type changed
                        if (initType != newType) {
                          //update user type
                          await widget.settingsCubit.updateUserType(
                            initType,
                            newType,
                          );

                          //logout
                          await context
                              .read<AuthCubit>()
                              .logout(user!.uid, newType);

                          //pop
                          Navigator.of(context).pop();
                        }
                      },
                      text: 'Save Changes',
                      padding: EdgeInsets.zero,
                      buttonPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {
              if (state is SettingsError) {
                GSnackBar.show(
                  context: context,
                  text: state.message,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
