import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/owner%20venues/representation/components/owner_events_card.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/approved/owner_approved_venues_cubit.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/approved/owner_approved_venues_states.dart';
import 'package:events_jo/features/owner%20venues/representation/pages/venues/approved/owner_approved_venue_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerApprovedVenuesPage extends StatefulWidget {
  const OwnerApprovedVenuesPage({super.key});

  @override
  State<OwnerApprovedVenuesPage> createState() =>
      _OwnerApprovedVenuesPageState();
}

class _OwnerApprovedVenuesPageState extends State<OwnerApprovedVenuesPage> {
  //user
  late final AppUser? user;

  //cubit
  late final OwnerApprovedVenuesCubit ownerApprovedVenuesCubit;

  @override
  void initState() {
    super.initState();

    //user
    user = UserManager().currentUser;

    //cubit
    ownerApprovedVenuesCubit = context.read<OwnerApprovedVenuesCubit>();

    //get approved venues stream
    ownerApprovedVenuesCubit.getApprovedVenuesStream(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerApprovedVenuesCubit, OwnerApprovedVenuesStates>(
      builder: (context, state) {
        //done
        if (state is OwnerApprovedVenuesLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return EmptyList(
              icon: CustomIcons.grin_beam,
              text: 'You don\'t have any requests for venues',
              gradient: GColors.logoGradient,
              color: GColors.royalBlue,
            );
          }

          return AnimatedListView(
            items: venues,
            shrinkWrap: true,
            enterTransition: [SlideInLeft()],
            exitTransition: [SlideInLeft()],
            insertDuration: const Duration(milliseconds: 300),
            removeDuration: const Duration(milliseconds: 300),
            isSameItem: (a, b) => a.id == b.id,
            itemBuilder: (context, index) {
              return OwnerEventsCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                key: Key(ownerApprovedVenuesCubit.generateUniqueId()),
                isApproved: venues[index].isApproved,
                isBeingApproved: venues[index].isBeingApproved,
                isLoading: false,
                icon: Icons.info_outline_rounded,
                //navigate to venue details
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return OwnerApprovedVenueDetailsPage(
                        weddingVenue: venues[index],
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
        //error
        if (state is OwnerApprovedVenuesError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const AdminEventListLoadingCard();
        }
      },
      listener: (context, state) {
        //error
        if (state is OwnerApprovedVenuesError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
      },
    );
  }
}
