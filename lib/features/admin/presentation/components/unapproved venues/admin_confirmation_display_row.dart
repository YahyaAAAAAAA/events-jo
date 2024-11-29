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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            mainText,
            style: TextStyle(
              color: GColors.poloBlue,
              fontSize: 21,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(width: 5),
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
                              color: GColors.cyanShade6,
                              fontSize: 21,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : IconButton(
                            onPressed: onPressed,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.cyanShade6),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              padding:
                                  const WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            icon: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: GColors.adminGradient,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  icon,
                                  color: GColors.white,
                                ),
                              ),
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
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              padding:
                                  const WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            icon: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: GColors.adminGradient,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  secondIcon,
                                  color: GColors.white,
                                ),
                              ),
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
