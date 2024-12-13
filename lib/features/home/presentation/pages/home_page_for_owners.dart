import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/owner/representation/pages/owner_page.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomePageForOwners extends StatefulWidget {
  const HomePageForOwners({
    super.key,
  });

  @override
  State<HomePageForOwners> createState() => _HomePageForOwnersState();
}

class _HomePageForOwnersState extends State<HomePageForOwners> {
  late final AppUser? user;

  //controls cards animation
  final AnimatedMeshGradientController animatedController =
      AnimatedMeshGradientController();

  List<XFile> images = [];

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
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          onPressed: () =>
              context.read<AuthCubit>().logout(user!.uid, user!.type),
          icon: Icons.person,
          size: 25,
        ),
        actions: [
          AppBarButton(
            onPressed: () {},
            icon: CustomIcons.menu,
            size: 20,
          ),
        ],
        leadingWidth: 90,
        toolbarHeight: 70,
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
                  child: GradientText(
                    "Welcome ${user!.name}",
                    gradient: GColors.logoGradient,
                    style: TextStyle(
                      color: GColors.poloBlue,
                      fontSize: 30,
                    ),
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

                //venues and owner
                FittedBox(
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
                      HomeCard(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OwnerPage(
                              user: user,
                            ),
                          ),
                        ),
                        controller: animatedController,
                        text: 'Owners',
                        icon: Icons.person,
                        colors: GColors.logoGradientColors,
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
                        onPressed: () {},
                        controller: animatedController,
                        text: 'Farms',
                        icon: CustomIcons.farm,
                        colors: GColors.farmCardGradient,
                      ),
                      HomeCard(
                        onPressed: () {},
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
