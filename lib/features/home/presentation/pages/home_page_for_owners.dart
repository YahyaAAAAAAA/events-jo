import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/home/presentation/components/sponserd_venue.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_page.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_list.dart';
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

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    weddingVenuesCubit = context.read<WeddingVenuesCubit>();
    if (weddingVenuesCubit.cachedVenues == null) {
      weddingVenuesCubit.getAllVenues();
    }
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
                //todo search bar
                VenueSearchBar(
                  controller: searchController,
                  onPressed: () => setState(
                    () => searchController.clear(),
                  ),
                  // onChanged: (venue) => weddingVenuesCubit.searchList(
                  //   venues,
                  //   venues,
                  //   venue,
                  // ),
                ),

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
                        onPressed: () {},
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor:
                                      WidgetStatePropertyAll(GColors.royalBlue),
                                ),
                        child: Text(
                          'Wedding Venues',
                          style: TextStyle(
                            color: GColors.white,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Farms',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Football Courts',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                20.height,

                const SponserdVenue(),

                20.height,

                //popular venues text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Wedding Venues",
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
                WeddingVenuesList(
                  user: user,
                  weddingVenuesCubit: weddingVenuesCubit,
                  searchController: searchController,
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
