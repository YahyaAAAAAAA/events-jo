import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_states.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_courts_tab_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_event_creation_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/stripe_not_completed_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/stripe_not_connect_page.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venues_tab_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerMainPage extends StatefulWidget {
  final AppUser? user;

  const OwnerMainPage({
    super.key,
    required this.user,
  });

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  late final StripeConnectCubit stripeConnectCubit;

  @override
  void initState() {
    super.initState();

    //listen to onboarding status
    stripeConnectCubit = context.read<StripeConnectCubit>();

    stripeConnectCubit.listenToOnboardingStatus(widget.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
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
              if (state is StripeConnectError) {
                context.showSnackBar(state.message);
              }
            }, builder: (context, state) {
              //not connected
              if (state is StripeNotConnected) {
                return StripeNotConnectedPage(
                  onPressed: () async {
                    final url = await stripeConnectCubit
                        .startOnboarding(widget.user!.uid);
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                );
              }

              //not completed
              if (state is StripeNotCompleted) {
                return StripeNotCompletedPage(
                  onPressed: () async {
                    final url = await stripeConnectCubit
                        .startOnboarding(widget.user!.uid);
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                );
              }
              //connected
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
                      OwnerEventCreationPage(user: widget.user),
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
