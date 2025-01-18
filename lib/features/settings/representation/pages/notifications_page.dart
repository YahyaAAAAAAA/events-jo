import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_switch.dart';
import 'package:flutter/material.dart';

//* prototype of the notifications page
class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Notifications Settings',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              //email
              SettingsSwitch(
                text: 'Email Notifications',
                value: emailNotifications,
                onChanged: (bool value) =>
                    setState(() => emailNotifications = value),
              ),

              const SizedBox(height: 20),

              //push
              SettingsSwitch(
                text: 'Push Notifications',
                value: pushNotifications,
                onChanged: (bool value) => setState(
                  () => pushNotifications = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
