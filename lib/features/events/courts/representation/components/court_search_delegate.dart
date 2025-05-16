import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/algorithms/ratings_utils.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/courts/representation/pages/football_courts_details_page.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:flutter/material.dart';

class CourtSearchDelegate extends SearchDelegate<FootballCourt?> {
  final BuildContext context;
  final AppUser? user;
  final List<FootballCourt> courts;

  CourtSearchDelegate(
    this.context,
    this.courts,
    this.user,
  );

  String selectedCity = 'All';
  String priceSort = 'None';
  String rateSort = 'None';

  @override
  String get searchFieldLabel => 'Search football courts...';

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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kOuterRadius),
              borderSide: BorderSide(
                color: GColors.black,
                width: 0.2,
              ),
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
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: GColors.black),
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
                            dropdownColor: GColors.white,
                            elevation: 1,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                              fontFamily: 'Abel',
                            ),
                            iconEnabledColor: GColors.black,
                            items: ['All', ...courts.map((c) => c.city).toSet()]
                                .toList()
                                .map((city) => DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
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
                            value: priceSort,
                            borderRadius: BorderRadius.circular(kOuterRadius),
                            dropdownColor: GColors.white,
                            elevation: 1,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                              fontFamily: 'Abel',
                            ),
                            iconEnabledColor: GColors.black,
                            items: [
                              'None',
                              'Price Ascending',
                              'Price Descending',
                            ]
                                .map((sort) => DropdownMenuItem(
                                      value: sort,
                                      child: Text(sort),
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
                          children: [Text('Rating')],
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
                            value: rateSort,
                            items: [
                              'None',
                              'Rate Ascending',
                              'Rate Descending',
                            ]
                                .map((sortOption) => DropdownMenuItem(
                                      value: sortOption,
                                      child: Text(sortOption),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                rateSort = value!;
                              });
                            },
                          ),
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

  @override
  Widget buildResults(BuildContext context) {
    var results = courts.where((court) {
      final matchesQuery =
          court.name.toLowerCase().contains(query.toLowerCase()) ||
              court.city.toLowerCase().contains(query.toLowerCase());
      final matchesCity = selectedCity == 'All' || court.city == selectedCity;
      return matchesQuery && matchesCity;
    }).toList();

    results = _applySorting(results);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final court = results[index];
        return SearchCourtCard(
          court: court,
          user: user,
          onTap: () => context.push(
            FootballCourtsDetailsPage(
              user: user,
              footballCourt: court,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = courts.where((court) {
      final matchesQuery =
          court.name.toLowerCase().contains(query.toLowerCase()) ||
              court.city.toLowerCase().contains(query.toLowerCase());
      final matchesCity = selectedCity == 'All' || court.city == selectedCity;
      return matchesQuery && matchesCity;
    }).toList();

    suggestions = _applySorting(suggestions);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final court = suggestions[index];
        return SearchCourtCard(
          court: court,
          user: user,
          onTap: () {
            context.push(
              FootballCourtsDetailsPage(
                user: user,
                footballCourt: court,
              ),
            );
          },
        );
      },
    );
  }

  List<FootballCourt> _applySorting(List<FootballCourt> courts) {
    if (priceSort == 'Price Ascending') {
      courts.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
    } else if (priceSort == 'Price Descending') {
      courts.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
    }

    if (rateSort == 'Rate Ascending') {
      courts.sort((a, b) => calculateRatings(b.rates)['averageRate']
          .toDouble()
          .compareTo(calculateRatings(a.rates)['averageRate'].toDouble()));
    } else if (rateSort == 'Rate Descending') {
      courts.sort((a, b) => calculateRatings(a.rates)['averageRate']
          .toDouble()
          .compareTo(calculateRatings(b.rates)['averageRate'].toDouble()));
    }

    return courts;
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

class SearchCourtCard extends StatelessWidget {
  const SearchCourtCard({
    super.key,
    required this.court,
    required this.user,
    this.onTap,
  });

  final FootballCourt court;
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
            imageUrl: court.pics.isEmpty ? kPlaceholderImage : court.pics[0],
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
        title: Text(court.name),
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
              Text(
                  '${(court.city.trim().isEmpty ? 'City NotFound' : court.city)}'),
              5.width,
              const Icon(
                Icons.price_change_outlined,
                size: kSmallIconSize,
              ),
              1.width,
              Text('${court.pricePerHour}JOD/hour'),
              5.width,
              const Icon(
                Icons.star_border_rounded,
                size: kSmallIconSize,
              ),
              1.width,
              Text(
                  '${calculateRatings(court.rates)['averageRate'].toStringAsFixed(1)} (${court.rates.length})'),
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
