import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_details_page.dart';
import 'package:flutter/material.dart';

class VenueSearchDelegate extends SearchDelegate<WeddingVenue?> {
  final BuildContext context;
  final AppUser? user;
  final List<WeddingVenue> venues;

  VenueSearchDelegate(
    this.context,
    this.venues,
    this.user,
  );

  String selectedCity = 'All';
  int? minPeople;
  int? maxPeople;
  String priceSort = 'None';
  String capacitySort = 'None';

  @override
  String get searchFieldLabel => 'Search venues...';

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        color: GColors.black,
        fontSize: kSmallFontSize,
        fontFamily: 'Abel',
      );

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      Theme.of(context).inputDecorationTheme.copyWith(
            filled: true,
            fillColor: GColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kOuterRadius),
              borderSide: BorderSide.none,
            ),
          );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: GColors.whiteShade3,
            actionsPadding: const EdgeInsets.all(8),
          ),
        );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AppBarButton(
        icon: Icons.arrow_back_ios_new_rounded,
        style: ButtonStyle(
          iconSize: const WidgetStatePropertyAll(kSmallIconSize),
          iconColor: WidgetStatePropertyAll(GColors.black),
          backgroundColor: WidgetStatePropertyAll(GColors.white),
        ),
        onPressed: () {
          close(context, null);
        },
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.filter_list,
          color: GColors.black,
          size: kNormalIconSize,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kOuterRadius)),
            backgroundColor: GColors.whiteShade3,
            showDragHandle: true,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        const Row(
                          children: [Text('City')],
                        ),
                        Flexible(
                          child: DropdownButtonFormField<String>(
                            decoration: dropDownbuttonDecoration(),
                            value: selectedCity,
                            borderRadius: BorderRadius.circular(kOuterRadius),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            dropdownColor: GColors.white,
                            elevation: 1,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                              fontFamily: 'Abel',
                            ),
                            iconEnabledColor: GColors.black,
                            items: ['All', ...venues.map((v) => v.city).toSet()]
                                .map((city) => DropdownMenuItem(
                                      value: city,
                                      child: FittedBox(child: Text(city)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value!;
                              });
                            },
                          ),
                        ),
                        const Row(
                          children: [Text('Price')],
                        ),
                        Flexible(
                          child: DropdownButtonFormField<String>(
                            decoration: dropDownbuttonDecoration(),
                            borderRadius: BorderRadius.circular(kOuterRadius),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            dropdownColor: GColors.white,
                            elevation: 1,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                              fontFamily: 'Abel',
                            ),
                            iconEnabledColor: GColors.black,
                            value: priceSort,
                            items: [
                              'None',
                              'Price Ascending',
                              'Price Descending',
                            ]
                                .map((sortOption) => DropdownMenuItem(
                                      value: sortOption,
                                      child: Text(sortOption),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                priceSort = value!;
                              });
                            },
                          ),
                        ),
                        const Row(
                          children: [Text('Capacity')],
                        ),
                        Flexible(
                          child: DropdownButtonFormField<String>(
                            decoration: dropDownbuttonDecoration(),
                            borderRadius: BorderRadius.circular(kOuterRadius),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            dropdownColor: GColors.white,
                            elevation: 1,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                              fontFamily: 'Abel',
                            ),
                            iconEnabledColor: GColors.black,
                            value: capacitySort,
                            items: [
                              'None',
                              'Capacity Ascending',
                              'Capacity Descending',
                            ]
                                .map((sortOption) => DropdownMenuItem(
                                      value: sortOption,
                                      child: Text(sortOption),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                capacitySort = value!;
                              });
                            },
                          ),
                        ),
                        const Row(
                          children: [Text('Capacity Range')],
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: RangeSlider(
                            values: RangeValues(
                              minPeople?.toDouble() ??
                                  venues.fold<double>(
                                      double.infinity,
                                      (min, venue) => venue.peopleMin < min
                                          ? venue.peopleMin.toDouble()
                                          : min),
                              maxPeople?.toDouble() ??
                                  venues.fold<double>(
                                      0,
                                      (max, venue) => venue.peopleMax > max
                                          ? venue.peopleMax.toDouble()
                                          : max),
                            ),
                            min: venues.fold<double>(
                                double.infinity,
                                (min, venue) => venue.peopleMin < min
                                    ? venue.peopleMin.toDouble()
                                    : min),
                            max: venues.fold<double>(
                                0,
                                (max, venue) => venue.peopleMax > max
                                    ? venue.peopleMax.toDouble()
                                    : max),
                            divisions: venues
                                .fold<double>(
                                    0,
                                    (max, venue) => venue.peopleMax > max
                                        ? venue.peopleMax.toDouble()
                                        : max)
                                .toInt(),
                            labels: RangeLabels(
                              '${minPeople ?? "Min"}',
                              '${maxPeople ?? "Max"}',
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                minPeople = values.start.toInt();
                                maxPeople = values.end.toInt();
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Min: ${minPeople ?? "Any"}'),
                            Text('Max: ${maxPeople ?? "Any"}'),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            context.pop();
                            setState(() {
                              this.query = ' ';
                              this.query = '';
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                GColors.whiteShade3.shade600),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kOuterRadius),
                              ),
                            ),
                          ),
                          icon: Text(
                            'Apply Filters',
                            style: TextStyle(
                              color: GColors.royalBlue,
                              fontSize: kSmallFontSize + 2,
                              fontFamily: 'Abel',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      10.width,
      IconButton(
        icon: Icon(
          Icons.clear,
          color: GColors.black,
          size: kSmallIconSize,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  Widget buildResults(BuildContext context) {
    var results = venues.where((venue) {
      final matchesQuery =
          venue.name.toLowerCase().contains(query.toLowerCase()) ||
              venue.city.toLowerCase().contains(query.toLowerCase());
      final matchesCity = selectedCity == 'All' || venue.city == selectedCity;
      final matchesPeople =
          (minPeople == null || venue.peopleMin >= minPeople!) &&
              (maxPeople == null || venue.peopleMax <= maxPeople!);
      return matchesQuery && matchesCity && matchesPeople;
    }).toList();

    results = _applySorting(results);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final venue = results[index];
        return SearchVenueCard(
          venue: venue,
          user: user,
          onTap: () => context.push(
            WeddingVenuesDetailsPage(
              user: user,
              weddingVenue: venue,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = venues.where((venue) {
      final matchesQuery =
          venue.name.toLowerCase().contains(query.toLowerCase()) ||
              venue.city.toLowerCase().contains(query.toLowerCase());
      final matchesCity = selectedCity == 'All' || venue.city == selectedCity;
      final matchesPeople =
          (minPeople == null || venue.peopleMin >= minPeople!) &&
              (maxPeople == null || venue.peopleMax <= maxPeople!);
      return matchesQuery && matchesCity && matchesPeople;
    }).toList();

    suggestions = _applySorting(suggestions);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final venue = suggestions[index];
        return SearchVenueCard(
          venue: venue,
          user: user,
          onTap: () {
            context.push(
              WeddingVenuesDetailsPage(
                user: user,
                weddingVenue: venue,
              ),
            );
          },
        );
      },
    );
  }

  List<WeddingVenue> _applySorting(List<WeddingVenue> venues) {
    if (priceSort == 'Price Ascending') {
      venues.sort((a, b) => a.peoplePrice.compareTo(b.peoplePrice));
    } else if (priceSort == 'Price Descending') {
      venues.sort((a, b) => b.peoplePrice.compareTo(a.peoplePrice));
    }

    if (capacitySort == 'Capacity Ascending') {
      venues.sort((a, b) => a.peopleMax.compareTo(b.peopleMax));
    } else if (capacitySort == 'Capacity Descending') {
      venues.sort((a, b) => b.peopleMax.compareTo(a.peopleMax));
    }

    return venues;
  }

  InputDecoration dropDownbuttonDecoration() {
    return InputDecoration(
      fillColor: GColors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kOuterRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kOuterRadius),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class SearchVenueCard extends StatelessWidget {
  const SearchVenueCard({
    super.key,
    required this.venue,
    required this.user,
    this.onTap,
  });

  final WeddingVenue venue;
  final AppUser? user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        tileColor: GColors.white,
        contentPadding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius)),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(kOuterRadius),
          child: CachedNetworkImage(
            imageUrl: venue.pics[0],
            placeholder: (context, url) => const GlobalLoadingImage(),
            errorWidget: (context, url, error) => Icon(
              Icons.error_outline,
              color: GColors.black,
              size: 40,
            ),
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Text(venue.name),
        titleTextStyle: TextStyle(
          color: GColors.black,
          fontSize: kSmallFontSize,
          fontFamily: 'Abel',
        ),
        subtitleTextStyle: TextStyle(
          color: GColors.black,
          fontSize: kSmallFontSize - 2,
          fontFamily: 'Abel',
        ),
        subtitle: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              const Icon(
                CustomIcons.map_marker,
                size: kSmallIconSize,
              ),
              1.width,
              Text('${venue.city}'),
              5.width,
              const Icon(
                Icons.people_alt_outlined,
                size: kSmallIconSize,
              ),
              1.width,
              Text('${venue.peopleMin}-${venue.peopleMax}'),
              5.width,
              const Icon(
                Icons.price_change_outlined,
                size: kSmallIconSize,
              ),
              1.width,
              Text('${venue.peoplePrice}JOD'),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: null,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kOuterRadius),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
          ),
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: GColors.white,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
