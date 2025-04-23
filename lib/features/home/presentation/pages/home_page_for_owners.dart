import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/widget_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/chat/representation/pages/chats_page.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/courts/representation/pages/football_courts_list.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/home/presentation/components/sponserd_venue.dart';
import 'package:events_jo/features/home/presentation/pages/venue_search_delegate.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_page.dart';
import 'package:events_jo/features/events/shared/representation/components/events_search_bar.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:events_jo/features/events/weddings/representation/pages/wedding_venues_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageForOwners extends StatefulWidget {
  const HomePageForOwners({
    super.key,
  });

  @override
  State<HomePageForOwners> createState() => _HomePageForOwnersState();
}

class _HomePageForOwnersState extends State<HomePageForOwners> {
  late final AppUser? user;
  late final WeddingVenuesCubit weddingVenuesCubit;
  late final FootballCourtsCubit footballCourtCubit;

  final TextEditingController searchController = TextEditingController();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    weddingVenuesCubit = context.read<WeddingVenuesCubit>();
    footballCourtCubit = context.read<FootballCourtsCubit>();

    if (weddingVenuesCubit.cachedVenues == null) {
      weddingVenuesCubit.getAllVenues();
    }

    //todo add cached
    footballCourtCubit.getAllCourts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: true,
        title: user?.name ?? 'Guest 123',
        onOwnerButtonTap: () => context.push(OwnerPage(user: user)),
        onChatsPressed: () => context.push(ChatsPage(user: user!)),
        onPressed: () =>
            context.read<AuthCubit>().logout(user!.uid, user!.type),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                BlocBuilder<WeddingVenuesCubit, WeddingVenuesStates>(
                  builder: (context, state) => EventSearchBar(
                    onPressed: state is WeddingVenuesLoaded
                        ? () => showSearch(
                              context: context,
                              delegate: VenueSearchDelegate(
                                context,
                                state.venues,
                                user,
                              ),
                            )
                        : null,
                  ),
                ),

                //TODO here
                BlocBuilder<FootballCourtsCubit, FootballCourtsStates>(
                  builder: (context, state) => EventSearchBar(
                    onPressed: state is FootballCourtsLoaded
                        ? () => showSearch(
                              context: context,
                              delegate: VenueSearchDelegate(
                                context,
                                [],
                                user,
                              ),
                            )
                        : null,
                  ),
                ).hide(),

                10.height,

                //categories text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ],
                ),

                5.height,

                //categories buttons
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    spacing: 5,
                    children: [
                      TextButton(
                        onPressed: () => setState(() => selectedTab = 0),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                      selectedTab == 0
                                          ? GColors.royalBlue
                                          : GColors.white),
                                ),
                        child: Text(
                          'Wedding Venues',
                          style: TextStyle(
                            color: selectedTab == 0
                                ? GColors.white
                                : GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => selectedTab = 1),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                      selectedTab == 1
                                          ? GColors.royalBlue
                                          : GColors.white),
                                ),
                        child: Text(
                          'Farms',
                          style: TextStyle(
                            color: selectedTab == 1
                                ? GColors.white
                                : GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => selectedTab = 2),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                      selectedTab == 2
                                          ? GColors.royalBlue
                                          : GColors.white),
                                ),
                        child: Text(
                          'Football Courts',
                          style: TextStyle(
                            color: selectedTab == 2
                                ? GColors.white
                                : GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                20.height,

                SponserdVenue(selectedTab: selectedTab),

                20.height,

                //popular venues text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTab == 0
                          ? "Popular Wedding Venues"
                          : "Popular Football Courts",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async =>
                          await weddingVenuesCubit.getAllVenues(),
                      style: Theme.of(context).iconButtonTheme.style?.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                              GColors.scaffoldBg,
                            ),
                          ),
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                  ],
                ),

                //venus list
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: selectedTab == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild:
                      WeddingVenuesList(key: const ValueKey(0), user: user),
                  secondChild:
                      FootballCourtsList(key: const ValueKey(1), user: user),
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
        height: 0,
      ),
    );
  }
}
