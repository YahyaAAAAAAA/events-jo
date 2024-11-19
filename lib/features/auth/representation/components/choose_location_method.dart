import 'dart:ui';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* Used in RegisterPage to give the user the option of picking location (manually) or  (automatically)
class ChooseLocationMethod extends StatelessWidget {
  final void Function()? onPressedManual;
  final void Function()? onPressedAuto;

  const ChooseLocationMethod({
    super.key,
    required this.onPressedAuto,
    required this.onPressedManual,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue)),
                icon: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      colors: GColors.logoGradient,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.clear,
                      color: GColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          titlePadding: const EdgeInsets.only(bottom: 10),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: GColors.whiteShade3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton.icon(
                  onPressed: onPressedManual,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(GColors.white),
                  ),
                  icon: Icon(
                    CustomIcons.map,
                    color: GColors.royalBlue,
                    size: 20,
                  ),
                  label: Text(
                    'Pick on Map',
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: onPressedAuto,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(GColors.white),
                  ),
                  icon: Icon(
                    Icons.gps_fixed_rounded,
                    color: GColors.royalBlue,
                    size: 20,
                  ),
                  label: Text(
                    'Locate from GPS',
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
