import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/representation/components/settings_icon_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_loading_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPage extends StatefulWidget {
  final SettingsCubit settingsCubit;

  const PrivacyPage({
    super.key,
    required this.settingsCubit,
  });

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  late final AppUser? user;

  //email controllers
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

  //password controllers
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;
  }

  @override
  void dispose() {
    super.dispose();
    oldEmailController.dispose();
    newEmailController.dispose();
    oldPasswordController.dispose();
    confirmNewPasswordController.dispose();
    newPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Privacy & Security',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              //text
              Text(
                'Change Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GColors.royalBlue,
                ),
              ),

              const SizedBox(height: 10),

              //old email field
              SettingsTextField(
                hintText: 'Old Email',
                controller: oldEmailController,
                onChanged: (value) =>
                    setState(() => oldEmailController.text = value),
              ),

              const SizedBox(height: 20),

              //new email field
              SettingsTextField(
                hintText: 'New Email',
                controller: newEmailController,
                onChanged: (value) =>
                    setState(() => newEmailController.text = value),
              ),

              const SizedBox(height: 20),

              //new email button
              BlocConsumer<SettingsCubit, SettingsStates>(
                builder: (context, state) {
                  //error
                  if (state is SettingsError) {
                    return Center(
                      child: SettingsTextButton(
                        onPressed: null,
                        text: state.message,
                        padding: EdgeInsets.zero,
                        buttonPadding: const EdgeInsets.all(20),
                      ),
                    );
                  }

                  //loading...
                  if (state is SettingsLoading) {
                    return const Center(
                      child: SettingsLoadingButton(
                        padding: EdgeInsets.zero,
                        buttonPadding: EdgeInsets.all(20),
                      ),
                    );
                  }

                  //loaded
                  return Center(
                    child: SettingsTextButton(
                      onPressed: () async {
                        //check if old email is empty
                        if (oldEmailController.text.trim().isEmpty) {
                          GSnackBar.show(
                            context: context,
                            text: 'Old email is empty',
                          );
                          return;
                        }

                        //check if new email is empty
                        if (newEmailController.text.trim().isEmpty) {
                          GSnackBar.show(
                            context: context,
                            text: 'New email is empty',
                          );
                          return;
                        }

                        //check if old email is correct
                        if (oldEmailController.text.trim() != user!.email) {
                          GSnackBar.show(
                            context: context,
                            text: 'Old email is incorrect',
                          );
                          return;
                        }

                        //check if old email is the same as the new email
                        if (oldEmailController.text.trim() ==
                            newEmailController.text.trim()) {
                          GSnackBar.show(
                            context: context,
                            text: 'Old email is the same as the new email',
                          );
                          return;
                        }

                        //update email
                        await widget.settingsCubit.updateUserEmail(
                          newEmailController.text,
                          oldEmailController.text,
                        );
                      },
                      text: 'Change Email',
                      padding: EdgeInsets.zero,
                      buttonPadding: const EdgeInsets.all(20),
                    ),
                  );
                },
                listener: (context, state) {
                  //email verification sent
                  if (state is SettingsEmailVerificationSent) {
                    GSnackBar.show(
                      context: context,
                      text: state.message,
                    );
                  }
                },
              ),

              const SizedBox(height: 40),

              //text
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GColors.royalBlue,
                ),
              ),

              const SizedBox(height: 10),

              //new password field
              SettingsTextField(
                hintText: 'Old Password',
                controller: oldPasswordController,
                isObscure: true,
                onChanged: (value) {
                  // Handle change password logic
                },
              ),

              const SizedBox(height: 20),

              //new password field
              SettingsTextField(
                hintText: 'New Password',
                controller: newPasswordController,
                isObscure: true,
                onChanged: (value) {
                  // Handle change password logic
                },
              ),

              const SizedBox(height: 20),

              //confirm new password field
              SettingsTextField(
                hintText: 'Confirm New Password',
                controller: confirmNewPasswordController,
                isObscure: true,
                onChanged: (value) {
                  // Handle change password logic
                },
              ),

              const SizedBox(height: 20),

              //new password button
              Center(
                child: SettingsTextButton(
                  onPressed: () {},
                  text: 'Change Password',
                  padding: EdgeInsets.zero,
                  buttonPadding: const EdgeInsets.all(20),
                ),
              ),

              const SizedBox(height: 40),

              Container(
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
                    //text
                    Text(
                      'Deactivate Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: GColors.redShade3,
                      ),
                    ),

                    //delete account button
                    Center(
                      child: SettingsIconButton(
                        //todo
                        onPressed: () {},
                        icon: Icons.delete_forever,
                        padding: EdgeInsets.zero,
                        buttonPadding: const EdgeInsets.all(20),
                        gradient: LinearGradient(
                          colors: [
                            GColors.redShade3,
                            GColors.redShade3,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
