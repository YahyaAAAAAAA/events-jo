import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
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
            padding: const EdgeInsets.all(12),
            children: [
              //change email button
              SettingsIconButton(
                onPressed: () => context.push(const UpdateEmailPage()),
                text: 'Change Account Email',
                icon: Icons.email,
              ),

              20.height,

              //change password button
              SettingsIconButton(
                onPressed: () => context.push(const UpdatePasswordPage()),
                text: 'Reset Account Password',
                icon: Icons.lock,
              ),

              20.height,

              //deactivate account button
              SettingsIconButton(
                //todo
                onPressed: () => context.showSnackBar('Coming soon...'),
                color: GColors.redShade3,
                text: 'Deactivate Account',
                icon: Icons.delete_forever,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
