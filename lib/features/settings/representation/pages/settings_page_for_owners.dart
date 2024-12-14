import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_banner.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_divider.dart';
import 'package:events_jo/features/settings/representation/components/settings_owners_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class SettingsPageForOwners extends StatefulWidget {
  const SettingsPageForOwners({super.key});

  @override
  State<SettingsPageForOwners> createState() => _SettingsPageForOwnersState();
}

class _SettingsPageForOwnersState extends State<SettingsPageForOwners> {
  late final AppUser? user;
  //controls cards animation
  final AnimatedMeshGradientController animatedController =
      AnimatedMeshGradientController();
  @override
  void initState() {
    super.initState();

    user = context.read<AuthCubit>().currentUser;

    animatedController.start();
  }

  @override
  void dispose() {
    super.dispose();
    animatedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onPressed: () => context.read<AuthCubit>().logout(
              user!.uid,
              user!.type,
            ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SettingsBanner(),

              const SizedBox(height: 20),

              const SettingsDivider(text: 'Account'),

              const SizedBox(height: 5),

              //account
              const SettingsCard(
                text: 'Your Account',
                icon: Icons.person,
                iconSize: 30,
              ),

              const SizedBox(height: 20),

              const SettingsDivider(text: 'Support'),

              const SizedBox(height: 5),

              const SettingsCard(
                text: 'Report Problem',
                icon: Icons.report_problem_rounded,
                iconSize: 30,
              ),

              const SizedBox(height: 10),

              const SettingsCard(
                text: 'Contact Support',
                iconSize: 30,
                icon: Icons.contact_support,
              ),

              const SizedBox(height: 20),

              const SettingsDivider(text: 'About'),

              const SizedBox(height: 5),

              const SettingsCard(
                text: 'About EventsJo',
                iconSize: 30,
                icon: Icons.info_rounded,
              ),

              const SizedBox(height: 20),

              const SettingsDivider(text: 'Owners'),

              const SizedBox(height: 5),

              SettingsOwnersCard(
                controller: animatedController,
                colors: GColors.weddingCardGradient,
                text: 'Your Venues',
                iconSize: 30,
                icon: CustomIcons.wedding,
              ),

              const SizedBox(height: 10),

              SettingsOwnersCard(
                controller: animatedController,
                colors: GColors.footballCardGradient,
                text: 'Your Courts',
                iconSize: 30,
                icon: CustomIcons.football,
              ),

              const SizedBox(height: 10),

              SettingsOwnersCard(
                controller: animatedController,
                colors: GColors.farmCardGradient,
                text: 'Your Farms',
                iconSize: 30,
                icon: CustomIcons.farm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
