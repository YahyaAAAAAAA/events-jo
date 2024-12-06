import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueSearchBarButton extends StatelessWidget {
  final void Function()? onTapAlpha;
  final void Function()? onTapNearest;
  final void Function()? onTapRate;
  final void Function()? onOpened;

  const VenueSearchBarButton({
    super.key,
    this.onTapAlpha,
    this.onTapNearest,
    this.onTapRate,
    this.onOpened,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        CustomIcons.sort,
        size: 20,
        color: GColors.black,
      ),
      onOpened: onOpened,
      style: ButtonStyle(
          shadowColor: WidgetStatePropertyAll(
            GColors.black.withOpacity(0.5),
          ),
          elevation: const WidgetStatePropertyAll(3),
          backgroundColor: WidgetStatePropertyAll(GColors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )),
      color: GColors.white,
      position: PopupMenuPosition.under,
      offset: const Offset(0, 20),
      constraints: const BoxConstraints.tightFor(width: 150),
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
            onTap: onTapAlpha,
            child: Text(
              'Sort Alphabetically',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            onTap: onTapNearest,
            child: Text(
              'Sort From Nearest',
              style: TextStyle(
                color: GColors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            onTap: onTapRate,
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
