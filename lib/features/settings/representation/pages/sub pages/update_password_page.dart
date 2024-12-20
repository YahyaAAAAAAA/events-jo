import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/representation/components/settings_loading_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:events_jo/features/settings/representation/cubits/password/password_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/password/password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late final AppUser? user;

  //password cubit
  late final PasswordCubit passwordCubit;

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

    //get cubit
    passwordCubit = context.read<PasswordCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Update Password',
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
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GColors.royalBlue,
                ),
              ),

              const SizedBox(height: 10),

              //old password field
              SettingsTextField(
                hintText: 'Old Password',
                controller: oldPasswordController,
                isObscure: true,
              ),

              const SizedBox(height: 20),

              //new password field
              SettingsTextField(
                hintText: 'New Password',
                controller: newPasswordController,
                isObscure: true,
              ),

              const SizedBox(height: 20),

              //confirm new password field
              SettingsTextField(
                hintText: 'Confirm New Password',
                controller: confirmNewPasswordController,
                isObscure: true,
              ),

              const SizedBox(height: 20),

              //new password button
              BlocConsumer<PasswordCubit, PasswordStates>(
                builder: (context, state) {
                  //loading...
                  if (state is PasswordLoading) {
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
                        //check if old password is empty
                        if (oldPasswordController.text.trim().isEmpty) {
                          GSnackBar.show(
                            context: context,
                            text: 'Old password is empty',
                          );
                          return;
                        }

                        //check if new password is empty
                        if (newPasswordController.text.trim().isEmpty) {
                          GSnackBar.show(
                            context: context,
                            text: 'New password is empty',
                          );
                          return;
                        }
                        //check if confirm new password is empty
                        if (confirmNewPasswordController.text.trim().isEmpty) {
                          GSnackBar.show(
                            context: context,
                            text: 'Confirm new password is empty',
                          );
                          return;
                        }

                        //check if passwords match
                        if (newPasswordController.text.trim() !=
                            confirmNewPasswordController.text.trim()) {
                          GSnackBar.show(
                            context: context,
                            text: 'Passwords do not match',
                          );
                          return;
                        }

                        //update password
                        await passwordCubit.updateUserPassword(
                            newPasswordController.text,
                            oldPasswordController.text);
                      },
                      text: 'Reset Password',
                      padding: EdgeInsets.zero,
                      buttonPadding: const EdgeInsets.all(20),
                    ),
                  );
                },
                listener: (context, state) {
                  //password updated
                  if (state is PasswordUpdated) {
                    GSnackBar.show(
                      context: context,
                      text: state.message,
                    );
                  }
                  //error
                  if (state is PasswordError) {
                    GSnackBar.show(
                      context: context,
                      text: state.message,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
