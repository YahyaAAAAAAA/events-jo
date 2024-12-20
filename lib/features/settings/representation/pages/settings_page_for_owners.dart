import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_divider.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/settings/representation/pages/account_page.dart';
import 'package:events_jo/features/settings/representation/pages/notifications_page.dart';
import 'package:events_jo/features/settings/representation/pages/privacy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPageForOwners extends StatefulWidget {
  const SettingsPageForOwners({super.key});

  @override
  State<SettingsPageForOwners> createState() => _SettingsPageForOwnersState();
}

class _SettingsPageForOwnersState extends State<SettingsPageForOwners> {
  late final AppUser? user;
  late final SettingsCubit settingsCubit;

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;

    //get cubit
    settingsCubit = context.read<SettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Settings',
        onPressed: () => context.read<AuthCubit>().logout(
              user!.uid,
              user!.type,
            ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: GColors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                //account
                SettingsCard(
                  text: 'Your Account',
                  icon: CustomIcons.portrait,
                  iconSize: 25,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountPage(
                        settingsCubit: settingsCubit,
                      ),
                    ),
                  ),
                ),

                const SettingsDivider(),

                SettingsCard(
                  text: 'Notifications',
                  icon: CustomIcons.bell,
                  iconSize: 25,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(),
                    ),
                  ),
                ),

                const SettingsDivider(),

                //privacy and security
                SettingsCard(
                  text: 'Privacy & Security',
                  icon: CustomIcons.lock,
                  iconSize: 25,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPage(
                        settingsCubit: settingsCubit,
                      ),
                    ),
                  ),
                ),

                const SettingsDivider(),

                //help and support
                SettingsCard(
                  text: 'Help and Support',
                  icon: CustomIcons.headphones,
                  iconSize: 25,
                  onTap: () => GSnackBar.show(
                    context: context,
                    text: 'Coming Soon',
                  ),
                ),

                const SettingsDivider(),

                //venues
                SettingsCard(
                  text: 'Your Venues',
                  iconSize: 25,
                  icon: CustomIcons.rings_wedding_1,
                  onTap: () => GSnackBar.show(
                    context: context,
                    text: 'Coming Soon',
                  ),
                ),

                const SettingsDivider(),

                //farms
                SettingsCard(
                  text: 'Your Farms',
                  iconSize: 25,
                  icon: CustomIcons.wheat,
                  onTap: () => GSnackBar.show(
                    context: context,
                    text: 'Coming Soon',
                  ),
                ),

                const SettingsDivider(),

                //courts
                SettingsCard(
                  text: 'Your Courts',
                  iconSize: 25,
                  icon: CustomIcons.football_1,
                  onTap: () => GSnackBar.show(
                    context: context,
                    text: 'Coming Soon',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Divider(
        color: GColors.poloBlue,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
