import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_icon_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/pages/sub%20pages/update_email_page.dart';
import 'package:events_jo/features/settings/representation/pages/sub%20pages/update_password_page.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({
    super.key,
  });

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
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
              //change email button
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
                    //change email text
                    Text(
                      'Change Account Email',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: GColors.royalBlue,
                      ),
                    ),

                    //change email button
                    Center(
                      child: SettingsIconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateEmailPage(),
                          ),
                        ),
                        icon: Icons.email,
                        padding: EdgeInsets.zero,
                        buttonPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              //change password button
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
                    //change password text
                    Text(
                      'Reset Account Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: GColors.royalBlue,
                      ),
                    ),

                    //change password button
                    Center(
                      child: SettingsIconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordPage(),
                          ),
                        ),
                        icon: Icons.lock,
                        padding: EdgeInsets.zero,
                        buttonPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              //deactivate account button
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
                        onPressed: () => GSnackBar.show(
                          context: context,
                          text: 'Coming soon...',
                        ),
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
