import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  const VenueSearchBar({
    super.key,
    required this.controller,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.height > 133
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(
              constraints: const BoxConstraints(maxWidth: 320),
              controller: controller,
              hintText: 'Search Venues...',
              shadowColor: WidgetStatePropertyAll(
                GColors.black.withValues(alpha: 0.5),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: GColors.black,
                ),
              ),
              elevation: const WidgetStatePropertyAll(3),
              backgroundColor: WidgetStatePropertyAll(GColors.white),
              trailing: [
                //clear search
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.clear,
                    color: GColors.black,
                  ),
                ),
              ],
              leading: Icon(
                Icons.search,
                color: GColors.black,
              ),
              //start search
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          )
        : const SizedBox();
  }
}
