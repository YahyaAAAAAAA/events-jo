import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/owner%20venues/representation/components/owner_events_card.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/unapproved/owner_unapproved_venues_cubit.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/unapproved/owner_unapproved_venues_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerUnapprovedVenuesPage extends StatefulWidget {
  const OwnerUnapprovedVenuesPage({super.key});

  @override
  State<OwnerUnapprovedVenuesPage> createState() =>
      _OwnerUnapprovedVenuesPageState();
}

class _OwnerUnapprovedVenuesPageState extends State<OwnerUnapprovedVenuesPage> {
  //user
  late final AppUser? user;

  //cubit
  late final OwnerUnapprovedVenuesCubit ownerUnapprovedVenuesCubit;

  @override
  void initState() {
    super.initState();

    //user
    user = UserManager().currentUser;

    //cubit
    ownerUnapprovedVenuesCubit = context.read<OwnerUnapprovedVenuesCubit>();

    //get approved venues stream
    ownerUnapprovedVenuesCubit.getUnapprovedVenuesStream(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerUnapprovedVenuesCubit,
        OwnerUnapprovedVenuesStates>(
      builder: (context, state) {
        //done
        if (state is OwnerUnapprovedVenuesLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return EmptyList(
              icon: CustomIcons.sad,
              text: 'You don\'t have any approved venues',
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
                icon: Icons.lock_clock,
                key: Key(ownerUnapprovedVenuesCubit.generateUniqueId()),
                isApproved: venues[index].isApproved,
                isBeingApproved: venues[index].isBeingApproved,
                isLoading: false,
                //todo make it cancelable (deny venue)
                //waiting for approval
                onPressed: () => GSnackBar.show(
                  context: context,
                  text: 'This venue is not approved yet',
                  color: GColors.royalBlue,
                  gradient: GColors.logoGradient,
                ),
              );
            },
          );
        }
        //error
        if (state is OwnerUnapprovedVenuesError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const AdminEventListLoadingCard();
        }
      },
      listener: (context, state) {
        //error
        if (state is OwnerUnapprovedVenuesError) {
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
