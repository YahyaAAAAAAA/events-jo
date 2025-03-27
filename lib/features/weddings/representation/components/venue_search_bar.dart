import 'package:events_jo/config/enums/jordan_city.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar_button.dart';
import 'package:flutter/material.dart';

class VenueSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(JordanCity)? onTapSortByCity;
  final void Function()? onTapSortByPriceAscend;
  final void Function()? onTapSortByPriceDescend;
  final void Function()? onTapSortByRate;
  final void Function()? onOpened;

  const VenueSearchBar({
    super.key,
    required this.controller,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
    this.onTapSortByCity,
    this.onTapSortByPriceAscend,
    this.onTapSortByPriceDescend,
    this.onTapSortByRate,
    this.onOpened,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      constraints: const BoxConstraints(
        maxWidth: kListViewWidth,
        minHeight: 47,
      ),
      controller: controller,
      hintText: 'Search Venues...',

      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: GColors.black,
        ),
      ),
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(GColors.white),
      trailing: [
        VenueSearchBarButton(
          onOpened: onOpened,
          onTapSortByCity: onTapSortByCity,
          onTapSortByPriceAscend: onTapSortByPriceAscend,
          onTapSortByPriceDescend: onTapSortByPriceDescend,
          onTapSortByRate: onTapSortByRate,
        ),
      ],
      leading: Icon(
        Icons.search,
        color: GColors.black,
      ),
      //start search
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
