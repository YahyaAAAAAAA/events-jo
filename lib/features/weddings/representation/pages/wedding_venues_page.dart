import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/weddings_search_bar.dart';
import 'package:events_jo/features/weddings/representation/components/wedding_venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 11/8/2024 lil break for midterm.
//TODO: BACK TRACK THE PROJECT , CHECK UI RESPONSIVENESS , MEMORY LEAK ,
// DOCUMENT THE PROJECT , MAYBE RENAME FILES AND THEN VENUE DETAILS.

class WeddingVenuesPage extends StatefulWidget {
  //get user
  final AppUser? appUser;

  const WeddingVenuesPage({
    super.key,
    required this.appUser,
  });

  @override
  State<WeddingVenuesPage> createState() => _WeddingVenuesPageState();
}

class _WeddingVenuesPageState extends State<WeddingVenuesPage> {
  late List<WeddingVenue> weddingVenuList = [];
  late List<WeddingVenue> filterdWeddingVenuList = [];
  late final WeddingVenueCubit weddingVenueCubit;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get cubit
    weddingVenueCubit = context.read<WeddingVenueCubit>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get original list
        weddingVenuList = await weddingVenueCubit.getAllVenues();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            'Wedding Venues in Jordan',
            style: TextStyle(
              color: GColors.black,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          //todo make sort menu
          //sort by closest,rating and availability

          //sort
          TextButton(
            onPressed: () {
              weddingVenueCubit.sortFromClosest(
                weddingVenuList,
                widget.appUser!.latitude,
                widget.appUser!.longitude,
              );
            },
            child: Icon(
              Icons.sort_by_alpha_rounded,
              color: GColors.black,
            ),
          )
        ],

        //back button
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: GColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
      ),

      //states
      body: BlocConsumer<WeddingVenueCubit, WeddingVenueStates>(
        builder: (context, state) {
          //list ready
          if (state is WeddingVenueLoaded) {
            return Column(
              children: [
                //search bar
                WeddingsSearchBar(
                  controller: searchController,
                  onPressed: () => setState(() => searchController.clear()),
                  onChanged: (venue) => weddingVenueCubit.searchList(
                      weddingVenuList, filterdWeddingVenuList, venue),
                ),

                //venues list
                Expanded(
                  child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? weddingVenuList.length
                        : filterdWeddingVenuList.length,
                    itemBuilder: (context, index) {
                      return WeddingVenueCard(
                        weddingVenue: searchController.text.isEmpty
                            ? weddingVenuList[index]
                            : filterdWeddingVenuList[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }

          //error
          if (state is WeddingVenueError) {
            return const Center(
              child: Text('Error getting venues list'),
            );
          }

          //loading...
          else {
            return const Center(
              child: LoadingIndicator(),
            );
          }
        },
        listener: (context, state) {
          //listens for errors
          if (state is WeddingVenueError) {
            GSnackBar.show(context: context, text: state.message);
          }
        },
      ),
    );
  }
}
