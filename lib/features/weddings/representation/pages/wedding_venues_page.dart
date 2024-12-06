import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar.dart';
import 'package:events_jo/features/weddings/representation/components/venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late List<WeddingVenue> filterdWeddingVenuList = [];
  late final WeddingVenueCubit weddingVenueCubit;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get cubit
    weddingVenueCubit = context.read<WeddingVenueCubit>();

    //listen to venues stream
    weddingVenueCubit.getWeddingVenuesStream();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
                //todo weddingVenueList,
                [],
                widget.appUser!.latitude,
                widget.appUser!.longitude,
              );
            },
            child: Icon(
              CustomIcons.sort,
              color: GColors.black,
              size: 20,
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: BlocConsumer<WeddingVenueCubit, WeddingVenueStates>(
            builder: (context, state) {
              //list ready
              if (state is WeddingVenueLoaded) {
                //get venues from stream
                final venues = state.venues;

                return Column(
                  children: [
                    //* search bar
                    VenueSearchBar(
                      controller: searchController,
                      onPressed: () => setState(() => searchController.clear()),
                      onChanged: (venue) => weddingVenueCubit.searchList(
                        venues,
                        filterdWeddingVenuList,
                        venue,
                      ),
                    ),

                    //* venues list
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchController.text.isEmpty
                            ? venues.length
                            : filterdWeddingVenuList.length,
                        itemBuilder: (context, index) => VenueCard(
                          weddingVenue: searchController.text.isEmpty
                              ? venues[index]
                              : filterdWeddingVenuList[index],
                        ),
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
                  child: GlobalLoadingBar(mainText: false),
                );
              }
            },
            listener: (context, state) {
              //listens for errors
              if (state is WeddingVenueError) {
                //todo add counter to make bar show only once
                GSnackBar.show(context: context, text: state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
