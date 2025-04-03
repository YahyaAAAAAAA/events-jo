import 'package:events_jo/config/extensions/int_extensions.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      icon: Row(
        spacing: 10,
        children: [
          0.width,
          Icon(
            Icons.search,
            color: GColors.black,
          ),
          Text(
            'Search Venues...',
            style: TextStyle(
              color: GColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
