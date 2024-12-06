import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar_button.dart';
import 'package:events_jo/features/weddings/representation/components/venues_app_bar.dart';
import 'package:events_jo/features/weddings/representation/components/venues_list_loading.dart';
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
  final AppUser? user;

  const WeddingVenuesPage({
    super.key,
    required this.user,
  });

  @override
  State<WeddingVenuesPage> createState() => _WeddingVenuesPageState();
}

class _WeddingVenuesPageState extends State<WeddingVenuesPage> {
  late final AppUser user;
  late List<WeddingVenue> filterdWeddingVenuList = [];
  late final WeddingVenueCubit weddingVenueCubit;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get user
    user = widget.user!;

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
      appBar: VenuesAppBar(user: widget.user),
      //states
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: BlocConsumer<WeddingVenueCubit, WeddingVenueStates>(
            builder: (context, state) {
              //list ready
              if (state is WeddingVenueLoaded) {
                //get venues from stream
                final venues = state.venues;

                return Column(
                  children: [
                    //* search bar
                    Row(
                      children: [
                        FittedBox(
                          child: VenueSearchBar(
                            controller: searchController,
                            onPressed: () =>
                                setState(() => searchController.clear()),
                            onChanged: (venue) => weddingVenueCubit.searchList(
                              venues,
                              filterdWeddingVenuList,
                              venue,
                            ),
                          ),
                        ),

                        //sort menu
                        VenueSearchBarButton(
                          onOpened: () =>
                              setState(() => searchController.clear()),
                          //todo sort alpha (deleted later)
                          onTapAlpha: () => weddingVenueCubit.sortAlpha(venues),
                          //sort from closest
                          onTapNearest: () => weddingVenueCubit.sortFromClosest(
                            venues,
                            user.latitude,
                            user.longitude,
                          ),
                          //sort by rate
                          onTapRate: () => GSnackBar.show(
                            context: context,
                            text: 'Coming Soon',
                          ),
                        ),
                      ],
                    ),

                    //* venues list
                    Expanded(
                      child: AnimatedListView(
                        items: searchController.text.isEmpty
                            ? venues
                            : filterdWeddingVenuList,
                        enterTransition: [SlideInLeft()],
                        exitTransition: [SlideInLeft()],
                        insertDuration: const Duration(milliseconds: 300),
                        removeDuration: const Duration(milliseconds: 300),
                        isSameItem: (a, b) => a.id == b.id,
                        itemBuilder: (context, index) => VenueCard(
                          isLoading: false,
                          key: Key(weddingVenueCubit.generateUniqueId()),
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
                return const VenuesListLoading();
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
