import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final void Function()? onPressed;

  const AdminButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return //* button
        Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: GColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        //navigate to details page
        child: IconButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(GColors.white),
            shadowColor: WidgetStatePropertyAll(
              GColors.black.withOpacity(0.5),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          icon: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: GColors.adminGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Icon(
                Icons.info_outline_rounded,
                color: GColors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
