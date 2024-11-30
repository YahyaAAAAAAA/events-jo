import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppUser? user;

  //controls cards animation
  final AnimatedMeshGradientController animatedController =
      AnimatedMeshGradientController();

  TextEditingController c = TextEditingController(); //temp

  @override
  void initState() {
    super.initState();

    animatedController.start();

    //get user
    user = widget.user;
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

                //todo work on icons (maybe add it in OwnerPage ?)
                //temp
                // Icon(
                //   IconForString.get(c.text),
                //   color: Colors.black,
                // ),
                // TextField(
                //   controller: c,
                //   onChanged: (value) {
                //     setState(() {
                //       c.text = value;
                //     });
                //   },
                // ),

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
                              appUser: user,
                            ),
                          ),
                        ),
                        controller: animatedController,
                        //todo add s after deleting personal event card
                        text: 'Wedding Venue',
                        icon: CustomIcons.wedding,
                        colors: GColors.weddingCardGradient,
                      ),
                      HomeCard(
                        onPressed: () {},
                        controller: animatedController,
                        text: 'Personal Event',
                        icon: Icons.person,
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
