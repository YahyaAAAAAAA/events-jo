import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/unique.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/courts/representation/pages/components/court_card.dart';
import 'package:events_jo/features/events/weddings/representation/components/error_venues.dart';
import 'package:events_jo/features/events/weddings/representation/components/no_venues.dart';
import 'package:events_jo/features/events/weddings/representation/components/venues_list_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballCourtsList extends StatelessWidget {
  //get user
  final AppUser? user;

  const FootballCourtsList({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCourtsCubit, FootballCourtsStates>(
      builder: (context, state) {
        //list ready
        if (state is FootballCourtsLoaded) {
          //get venues from stream
          final courts = state.courts;

          if (courts.isEmpty) {
            return const NoVenues(
              icon: CustomIcons.sad,
              text: 'No Football Courts Available',
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
            ),
            itemCount: courts.length,
            itemBuilder: (context, index) => CourtCard(
              user: user,
              key: Key(Unique.generateUniqueId()),
              footballCourt: courts[index],
            ),
          );
        }

        //error
        if (state is FootballCourtsError) {
          return const ErrorVenues(
            icon: CustomIcons.sad,
            text: 'Error getting Football Courts',
          );
        }

        //loading...
        else {
          return const VenuesListLoading();
        }
      },
      listener: (context, state) async {
        //listens for errors
        if (state is FootballCourtsError) {
          //todo add counter to make bar show only once
          GSnackBar.show(context: context, text: state.message);
        }
      },
    );
  }
}
