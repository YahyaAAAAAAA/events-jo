import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/gradient/gradient_icon.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppUser? user;

  //controls cards animation
  final AnimatedMeshGradientController animatedController =
      AnimatedMeshGradientController();

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

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
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                //logo
                const EventsJoLogo(),

                const SizedBox(height: 10),

                //welcome text
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      //icon
                      GradientIcon(
                        icon: Icons.waving_hand_outlined,
                        gradient: GColors.logoGradient,
                        size: 40,
                      ),

                      const SizedBox(width: 10),

                      //user name
                      GradientText(
                        "Welcome ${user!.name.toCapitalized}",
                        gradient: GColors.logoGradient,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                //text
                Center(
                  child: Text(
                    "Browse a category",
                    style: TextStyle(
                      color: GColors.poloBlue,
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //venues
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      HomeCard(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WeddingVenuesPage(
                              user: user,
                            ),
                          ),
                        ),
                        controller: animatedController,
                        text: 'Wedding Venues',
                        icon: CustomIcons.wedding,
                        colors: GColors.weddingCardGradient,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                //farms and courts
                FittedBox(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      HomeCard(
                        onPressed: () => GSnackBar.show(
                          context: context,
                          text: 'Coming soon',
                        ),
                        controller: animatedController,
                        text: 'Farms',
                        icon: CustomIcons.farm,
                        colors: GColors.farmCardGradient,
                      ),
                      HomeCard(
                        onPressed: () => GSnackBar.show(
                          context: context,
                          text: 'Coming soon',
                        ),
                        controller: animatedController,
                        text: 'Football Courts',
                        icon: CustomIcons.football,
                        colors: GColors.footballCardGradient,
                      ),
                    ],
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
