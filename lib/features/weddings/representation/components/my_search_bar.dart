import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  const MySearchBar({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SearchBar(
        controller: controller,
        hintText: 'Search Venues...',
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: GColors.black,
          ),
        ),
        elevation: const WidgetStatePropertyAll(0),
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
      ),
    );
  }
}
