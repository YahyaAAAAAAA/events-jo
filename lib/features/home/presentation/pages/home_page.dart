import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/pages/owner_page.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weddingVenueRepo = FirebaseWeddingVenueRepo();
  final AnimatedMeshGradientController animatedController =
      AnimatedMeshGradientController();
  late AppUser? currentUser;
  late Position? location;

  @override
  void initState() {
    super.initState();

    animatedController.start();

    //get user
    currentUser = context.read<AuthCubit>().currentUser!;
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
          onPressed: () => context.read<AuthCubit>().logout(),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EventsJoLogo(),

                const SizedBox(height: 20),

                Text(
                  "Browse a category",
                  style: TextStyle(
                    color: GColors.poloBlue,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 10),

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
                              appUser: currentUser,
                            ),
                          ),
                        ),
                        controller: animatedController,
                        text: 'Wedding Venue',
                        subText: 'See wedding venues in Jordan',
                        icon: CustomIcons.wedding,
                        index: 1,
                        colors: GColors.weddingCardGradient,
                      ),
                      HomeCard(
                        onPressed: () {},
                        controller: animatedController,
                        text: 'Personal Event',
                        subText: 'Book your own event',
                        icon: Icons.person,
                        index: 2,
                        colors: GColors.personalCardGradient,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                FittedBox(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      HomeCard(
                        onPressed: () {},
                        controller: animatedController,
                        text: 'Book Farms',
                        subText: 'See farms in Jordan',
                        icon: CustomIcons.farm,
                        index: 3,
                        colors: GColors.farmCardGradient,
                      ),
                      HomeCard(
                        onPressed: () {},
                        controller: animatedController,
                        text: 'Football Courts',
                        subText: 'See football courts in Jordan',
                        icon: CustomIcons.football,
                        index: 4,
                        colors: GColors.footballCardGradient,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                //display button if user is an owner
                currentUser!.type == 'owner'
                    ? FittedBox(
                        child: OwnerButton(
                          text: 'Add Your Venue, Farm or Court',
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          icon: Icons.add,
                          iconSize: 50,
                          padding: 8,
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OwnerPage(
                                user: currentUser,
                              ),
                            ),
                          ),
                        ),
                      )
                    //else display nothing
                    : const SizedBox(),
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
