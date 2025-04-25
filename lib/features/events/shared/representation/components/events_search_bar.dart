import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class EventSearchBar extends StatelessWidget {
  final void Function()? onPressed;
  final String? hintText;

  const EventSearchBar({
    super.key,
    this.onPressed,
    this.hintText,
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
            hintText ?? 'Search Events...',
            style: TextStyle(
              color: GColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
