import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminConfirmationDisplayRow extends StatelessWidget {
  final String mainText;
  final String subText;

  //if false display button instead
  final bool isText;
  final bool withSecondIcon;
  final IconData icon;
  final IconData secondIcon;
  final void Function()? onPressed;
  final void Function()? onPressedSecondIcon;

  const AdminConfirmationDisplayRow({
    super.key,
    required this.mainText,
    required this.subText,
    this.isText = true,
    this.withSecondIcon = false,
    this.icon = Icons.location_on_outlined,
    this.secondIcon = Icons.location_on_outlined,
    this.onPressed,
    this.onPressedSecondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(kOuterRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                GColors.cyanShade6.shade300.withValues(alpha: 0.2),
              ),
            ),
            icon: Icon(
              Icons.info,
              color: GColors.cyanShade6,
              size: kNormalIconSize,
            ),
          ),
          10.width,
          Text(
            mainText,
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
          5.width,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: isText
                        ? Text(
                            subText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                            ),
                          )
                        : IconButton(
                            onPressed: onPressed,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.cyanShade6),
                            ),
                            icon: Icon(
                              icon,
                              color: GColors.white,
                            ),
                          ),
                  ),
                ),
                withSecondIcon ? const SizedBox(width: 10) : const SizedBox(),
                withSecondIcon
                    ? Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: IconButton(
                            onPressed: onPressedSecondIcon,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.cyanShade6),
                            ),
                            icon: Icon(
                              secondIcon,
                              color: GColors.white,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
