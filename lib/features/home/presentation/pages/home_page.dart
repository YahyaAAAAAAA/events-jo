import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/my_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/pages/owner_page.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
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
  //dev delete or use it later ?
  String imgSwitch = '';

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

  //dev for later
  Widget addToDatabaseButton() {
    return TextButton(
      onPressed: () async {
        //* adding new venus to database (for me)
        WeddingVenue weddingVenue = WeddingVenue(
          latitude: "31.84480325226184",
          longitude: "35.88135319995705",
          name: "country club".toTitleCase,
          openTime: "10 AM–10 PM",
          isOpen: true,
          owner: currentUser!.uid,
          pics: [
            'https://i.ibb.co/ZVf53hB/placeholder.png',
          ],
          rate: 0,
        );
        FirebaseFirestore.instance
            .collection('venues')
            .add(weddingVenue.toJson());
      },
      child: const Text('add to database'),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const EventsJoLogo(),

            const SizedBox(height: 50),

            Text(
              "Browse a category",
              style: TextStyle(
                color: MyColors.poloBlue,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                ),
                children: [
                  HomeCard(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WeddingVenuesPage(),
                      ),
                    ),
                    controller: animatedController,
                    text: 'Wedding Venue',
                    subText: 'See wedding venues in Jordan',
                    icon: CustomIcons.wedding,
                    index: 1,
                    colors: MyColors.weddingCardGradient,
                    //background-image: linear-gradient(to top, #dbdcd7 0%, #dddcd7 24%, #e2c9cc 30%, #e7627d 46%, #b8235a 59%, #801357 71%, #3d1635 84%, #1c1a27 100%);
                  ),
                  HomeCard(
                    onPressed: () {},
                    controller: animatedController,
                    text: 'Personal Event',
                    subText: 'Book your own event',
                    icon: Icons.person,
                    index: 2,
                    colors: MyColors.personalCardGradient,
                  ),
                  HomeCard(
                    onPressed: () {},
                    controller: animatedController,
                    text: 'Book Farms',
                    subText: 'See farms in Jordan',
                    icon: CustomIcons.farm,
                    index: 3,
                    colors: MyColors.farmCardGradient,
                  ),
                  HomeCard(
                    onPressed: () {},
                    controller: animatedController,
                    text: 'Football Courts',
                    subText: 'See football courts in Jordan',
                    icon: CustomIcons.football,
                    index: 4,
                    colors: MyColors.footballCardGradient,
                  ),
                ],
              ),
            ),

            //display button if user is an owner
            currentUser!.type == 'owner'
                ? OwnerButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OwnerPage(),
                      ),
                    ),
                  )
                //else display nothing
                : const SizedBox(),

            const SizedBox(height: 10),

            //dev add this for (orders,settings) screens
            Divider(
              color: MyColors.poloBlue,
              thickness: 0.5,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }
}

//dev extend string class -> capitlize the begging of every word
extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}
