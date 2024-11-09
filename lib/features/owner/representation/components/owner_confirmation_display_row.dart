import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerConfirmationDisplayRow extends StatelessWidget {
  final String mainText;
  final String subText;

  //if false display button instead
  final bool isText;
  final IconData icon;
  final void Function()? onPressed;

  const OwnerConfirmationDisplayRow({
    super.key,
    required this.mainText,
    required this.subText,
    this.isText = true,
    this.icon = Icons.location_on_outlined,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
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
                              color: GColors.royalBlue,
                              fontSize: 21,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : IconButton(
                            onPressed: onPressed,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.royalBlue),
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
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  colors: GColors.logoGradient,
                                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
