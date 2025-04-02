import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueSearchBar extends StatelessWidget {
  final void Function()? onPressed;

  const VenueSearchBar({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        constraints: const BoxConstraints(
          maxWidth: kListViewWidth,
          minHeight: 47,
        ),
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(kOuterRadius),
          boxShadow: const [],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(
              Icons.search,
              color: GColors.black,
            ),
            const SizedBox(width: 8),
            Text(
              'Search Venues...',
              style: TextStyle(
                color: GColors.black,
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
