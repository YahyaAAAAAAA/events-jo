import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_states.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_courts_tab_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_event_creation_page.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venues_tab_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerMainPage extends StatelessWidget {
  final AppUser? user;

  const OwnerMainPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    print(user?.stripeAccountId);
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Owner Page',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocConsumer<StripeConnectCubit, StripeConnectStates>(
                listener: (context, state) async {
              print(state);
              print(user?.stripeAccountId);

              if (state is StripeConnectError) {
                context.showSnackBar(state.message);
              }
              if (state is StripeConnected) {
                final uri = Uri.parse(state.stripeConnect.onboardingUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            }, builder: (context, state) {
              if (state is StripeConnectLoading) {
                return const GlobalLoadingBar(mainText: false);
              }

              if (state is StripeConnected) {
                // user?.stripeAccountId = state.stripeConnect.stripeAccountId;
                // user?.onboardingStatus = state.stripeConnect.stripeAccountId;
              }

              if (user?.stripeAccountId == null) {
                return TextButton(
                  onPressed: () async {
                    await context.read<StripeConnectCubit>().start(user!.uid);
                  },
                  child: const Text('data'),
                );
              }
              return ListView(
                children: [
                  Text(
                    'Create Events',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.height,
                  SettingsCard(
                    text: 'Create an Event',
                    icon: Icons.create_rounded,
                    onTap: () => context.push(
                      OwnerEventCreationPage(user: user),
                    ),
                  ),
                  10.height,
                  Text(
                    'Your Events',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kSmallFontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.height,
                  SettingsCard(
                    text: 'Your Venues',
                    icon: CustomIcons.wedding,
                    onTap: () => context.push(const OwnerVenuesTabPage()),
                  ),
                  10.height,
                  SettingsCard(
                    text: 'Your Courts',
                    icon: CustomIcons.football_1,
                    onTap: () => context.push(const OwnerCourtsTabPage()),
                  ),
                  10.height,
                  SettingsCard(
                    text: 'Your Farms',
                    icon: CustomIcons.wheat,
                    isComingSoon: true,
                    onTap: () => context.showSnackBar('Coming Soon'),
                  ),
                  10.height,
                  SettingsCard(
                    text: 'Your Pools',
                    icon: Icons.pool,
                    isComingSoon: true,
                    onTap: () => context.showSnackBar('Coming Soon'),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
