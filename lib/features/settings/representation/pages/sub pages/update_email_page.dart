import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/representation/components/settings_loading_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:events_jo/features/settings/representation/cubits/email/email_cubit.dart';
import 'package:events_jo/features/settings/representation/cubits/email/email_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({super.key});

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  late final AppUser? user;

  //email cubit
  late final EmailCubit emailCubit;

  //email controllers
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController oldPasswordForEmailController =
      TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;

    //get cubit
    emailCubit = context.read<EmailCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    oldEmailController.dispose();
    newEmailController.dispose();
    oldPasswordForEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Update Email',
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
                  fontSize: kNormalFontSize,
                  fontWeight: FontWeight.bold,
                  color: GColors.black,
                ),
              ),

              const SizedBox(height: 10),

              //old email field
              SettingsTextField(
                hintText: 'Old Email',
                controller: oldEmailController,
              ),

              const SizedBox(height: 20),

              //new email field
              SettingsTextField(
                hintText: 'New Email',
                controller: newEmailController,
              ),

              const SizedBox(height: 20),

              //new email field
              SettingsTextField(
                hintText: 'Current Password',
                controller: oldPasswordForEmailController,
                isObscure: true,
              ),

              const SizedBox(height: 20),

              //new email button
              BlocConsumer<EmailCubit, EmailStates>(
                builder: (context, state) {
                  //loading...
                  if (state is EmailLoading) {
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
                          context.showSnackBar('Old email is empty');
                          return;
                        }

                        //check if new email is empty
                        if (newEmailController.text.trim().isEmpty) {
                          context.showSnackBar('New email is empty');
                          return;
                        }

                        //check if old email is correct
                        if (oldEmailController.text.trim() != user!.email) {
                          context.showSnackBar('Old email is incorrect');
                          return;
                        }

                        //check if old email is the same as the new email
                        if (oldEmailController.text.trim() ==
                            newEmailController.text.trim()) {
                          context.showSnackBar(
                              'Old email is the same as the new email');
                          return;
                        }

                        //check if password is empty
                        if (oldPasswordForEmailController.text.trim().isEmpty) {
                          context.showSnackBar('Password is empty');
                          return;
                        }

                        //update email
                        await emailCubit.updateUserEmail(
                          newEmailController.text,
                          oldEmailController.text,
                          oldPasswordForEmailController.text,
                        );
                      },
                      text: 'Change Email',
                    ),
                  );
                },
                listener: (context, state) {
                  //email verification sent
                  if (state is EmailVerificationSent) {
                    context.showSnackBar(state.message);
                  }
                  //error
                  if (state is EmailError) {
                    context.showSnackBar(state.message);
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
