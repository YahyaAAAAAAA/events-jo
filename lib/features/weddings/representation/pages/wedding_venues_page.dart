import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/enums/sort_direction.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/weddings/representation/components/error_venues.dart';
import 'package:events_jo/features/weddings/representation/components/no_venues.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar_button.dart';
import 'package:events_jo/features/weddings/representation/components/venues_app_bar.dart';
import 'package:events_jo/features/weddings/representation/components/venues_list_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar.dart';
import 'package:events_jo/features/weddings/representation/components/venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_states.dart';
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
  late final WeddingVenuesCubit weddingVenueCubit;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get user
    user = widget.user!;

    //get cubit
    weddingVenueCubit = context.read<WeddingVenuesCubit>();

    //listen to venues stream
    weddingVenueCubit.getVenuesStream();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VenuesAppBar(user: user),
      //states
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: BlocConsumer<WeddingVenuesCubit, WeddingVenuesStates>(
            builder: (context, state) {
              //list ready
              if (state is WeddingVenuesLoaded) {
                //get venues from stream
                final venues = state.venues;

                if (venues.isEmpty) {
                  return const NoVenues(
                    icon: CustomIcons.sad,
                    text: 'No Wedding Venues Available',
                  );
                }

                return Column(
                  children: [
                    //* search bar
                    Row(
                      children: [
                        FittedBox(
                          child: VenueSearchBar(
                            controller: searchController,
                            onPressed: () => setState(
                              () => searchController.clear(),
                            ),
                            onChanged: (venue) => weddingVenueCubit.searchList(
                              venues,
                              filterdWeddingVenuList,
                              venue,
                            ),
                          ),
                        ),

                        //sort menu
                        VenueSearchBarButton(
                          onOpened: () => setState(
                            () => searchController.clear(),
                          ),
                          onTapSortByCity: (city) => setState(
                            () => weddingVenueCubit.sortByCity(
                              venues,
                              city.name,
                            ),
                          ),
                          //sort by price ascending order
                          onTapSortByPriceAscend: () =>
                              weddingVenueCubit.sortByPrice(
                            venues,
                            SortDirection.ascending,
                          ),
                          //sort by price descending order
                          onTapSortByPriceDescend: () =>
                              weddingVenueCubit.sortByPrice(
                            venues,
                            SortDirection.descending,
                          ),
                          //sort by rate
                          onTapSortByRate: () => GSnackBar.show(
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
                          user: user,
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
                return const ErrorVenues(
                  icon: CustomIcons.sad,
                  text: 'Error getting Wedding Venues',
                );
              }

              //loading...
              else {
                return const VenuesListLoading();
              }
            },
            listener: (context, state) async {
              if (state is WeddingVenuesLoaded) {
                // for (int i = 0; i < state.venues.length; i++) {
                //   state.venues[i].city = await weddingVenueCubit.getCity(
                //         state.venues[i].latitude,
                //         state.venues[i].longitude,
                //       ) ??
                //       'x';
                // }
              }
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
