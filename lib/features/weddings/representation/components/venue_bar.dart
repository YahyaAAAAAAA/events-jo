import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueBar extends StatelessWidget {
  final void Function()? onPressedNext;
  final void Function()? onPressedBack;
  final int index;

  const VenueBar({
    super.key,
    required this.onPressedNext,
    required this.onPressedBack,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        color: GColors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //back button
          Row(
            children: [
              IconButton(
                onPressed: onPressedBack,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                  shadowColor: WidgetStatePropertyAll(
                    GColors.black.withOpacity(0.5),
                  ),
                  elevation: const WidgetStatePropertyAll(3),
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
                    gradient: GColors.logoGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: GColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Cancel',
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 25,
                ),
              ),
            ],
          ),

          //next button
          Row(
            children: [
              Text(
                'Checkout',
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 25,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: onPressedNext,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                    shadowColor: WidgetStatePropertyAll(
                      GColors.black.withOpacity(0.5),
                    ),
                    elevation: const WidgetStatePropertyAll(3),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
                icon: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: GColors.logoGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                      color: GColors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
