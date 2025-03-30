import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerTabItem extends StatelessWidget {
  final String title;
  final int count;

  const OwnerTabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
          count > 0
              ? Container(
                  margin: const EdgeInsetsDirectional.only(start: 10),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: GColors.whiteShade3,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      count > 9 ? "9+" : count.toString(),
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
