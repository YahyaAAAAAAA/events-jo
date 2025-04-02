import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/weddings/representation/components/error_venues.dart';
import 'package:events_jo/features/weddings/representation/components/no_venues.dart';
import 'package:events_jo/features/weddings/representation/components/venues_list_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/representation/components/venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenuesList extends StatelessWidget {
  //get user
  final AppUser? user;
  final WeddingVenuesCubit weddingVenuesCubit;

  const WeddingVenuesList({
    super.key,
    required this.user,
    required this.weddingVenuesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeddingVenuesCubit, WeddingVenuesStates>(
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

          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
            ),
            itemCount: venues.length,
            itemBuilder: (context, index) => VenueCard(
              user: user,
              key: Key(weddingVenuesCubit.generateUniqueId()),
              weddingVenue: venues[index],
            ),
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
        //listens for errors
        if (state is WeddingVenueError) {
          //todo add counter to make bar show only once
          GSnackBar.show(context: context, text: state.message);
        }
      },
    );
  }
}
