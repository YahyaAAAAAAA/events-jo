import 'package:events_jo/config/enums/jordan_city.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueSearchBarButton extends StatelessWidget {
  final void Function(JordanCity)? onTapSortByCity;
  final void Function()? onTapSortByPriceAscend;
  final void Function()? onTapSortByPriceDescend;
  final void Function()? onTapSortByRate;
  final void Function()? onOpened;

  const VenueSearchBarButton({
    super.key,
    this.onTapSortByCity,
    this.onTapSortByPriceAscend,
    this.onTapSortByPriceDescend,
    this.onTapSortByRate,
    this.onOpened,
  });

  @override
  Widget build(BuildContext context) {
    //* main menu
    return PopupMenuButton(
      icon: Icon(
        CustomIcons.sort,
        size: 20,
        color: GColors.black,
      ),

      onOpened: onOpened,
      style: ButtonStyle(
        shadowColor: WidgetStatePropertyAll(
          GColors.black.withValues(alpha: 0.5),
        ),
        elevation: const WidgetStatePropertyAll(3),
        backgroundColor: WidgetStatePropertyAll(GColors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      color: GColors.white,
      position: PopupMenuPosition.under,
      offset: const Offset(0, 20),
      // constraints: const BoxConstraints.tightFor(width: 150),
      initialValue: 0,
      tooltip: '',
      popUpAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 200),
      ),
      padding: const EdgeInsets.all(15),
      itemBuilder: (BuildContext context) {
        return [
          //menu items
          PopupMenuItem(
            onTap: null,
            //* cities menu
            child: PopupMenuButton(
              icon: Text(
                'Sort By City',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 17,
                ),
              ),
              color: GColors.white,
              onSelected: onTapSortByCity,
              itemBuilder: (context) {
                return List.generate(
                  JordanCity.values.length,
                  (index) {
                    return PopupMenuItem(
                      value: JordanCity.values[index],
                      child: Text(
                        JordanCity.values[index].name,
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 17,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          PopupMenuItem(
            onTap: onTapSortByPriceAscend,
            child: Text(
              'Sort By Price (Ascend)',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            onTap: onTapSortByPriceDescend,
            child: Text(
              'Sort By Price (Descend)',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            onTap: onTapSortByRate,
            child: Text(
              'Sort By Rate',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ];
      },
    );
  }
}
