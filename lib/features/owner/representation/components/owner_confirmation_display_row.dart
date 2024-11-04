import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerConfirmationDisplayRow extends StatelessWidget {
  final String mainText;
  final String subText;
  const OwnerConfirmationDisplayRow({
    super.key,
    required this.mainText,
    required this.subText,
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
                    child: Text(
                      subText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 21,
                        fontWeight: FontWeight.normal,
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
