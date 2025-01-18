import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_divider.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController subjectController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Help & Support',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: GColors.black.withValues(alpha: 0.3),
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      children: [
                        SettingsCard(
                          text: 'What is EventsJo',
                          icon: CustomIcons.messages_question,
                          iconSize: 25,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: GColors.whiteShade3,
                                content: Text(
                                  'EventsJo is a comprehensive cross-platform mobile application designed to streamline the process of booking venues for various occasions in Jordan. Whether its a wedding, a football match, or a relaxing getaway at a farm, EventsJo connects users with available venues, making reservations simple and hassle-free. The app features user-friendly authentication, seamless payment options (cash or credit card), and detailed tracking of past and upcoming events.',
                                  style: TextStyle(
                                    color: GColors.royalBlue,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SettingsDivider(),
                        SettingsCard(
                          text: 'About Us',
                          icon: CustomIcons.info,
                          iconSize: 25,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: GColors.whiteShade3,
                                content: Text(
                                  'We are a team of four passionate Computer Science students from Hashemite University, united by our goal to make event planning easier for everyone in Jordan. EventsJo is our graduation project, reflecting our dedication to combining technical expertise with real-world solutions. Together, we aim to leave a positive mark by simplifying venue bookings and bringing convenience to users at their fingertips.',
                                  style: TextStyle(
                                    color: GColors.royalBlue,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Email Input
                    SettingsTextField(
                      controller: subjectController,
                      hintText: 'Subject',
                    ),

                    const SizedBox(height: 10),

                    // Message Input
                    SettingsTextField(
                      controller: messageController,
                      hintText: 'Message',
                      maxLines: 5,
                    ),

                    const SizedBox(height: 20),

                    // Submit Button
                    Center(
                      child: SettingsTextButton(
                        text: 'Submit',
                        onPressed: () {
                          setState(() {
                            subjectController.clear();
                            messageController.clear();
                          });
                          GSnackBar.show(
                            context: context,
                            text: 'Your message has been sent, Thank you',
                          );
                        },
                        padding: EdgeInsets.zero,
                        buttonPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
