import 'package:events_jo/config/utils/constants.dart';
import 'package:flutter/material.dart';

class EventRate extends StatelessWidget {
  final int rating;
  final ValueChanged<int>? onRatingChanged;
  final double starSize;
  final Color fullColor;
  final Color emptyColor;

  const EventRate({
    super.key,
    required this.fullColor,
    required this.emptyColor,
    this.rating = 0,
    this.onRatingChanged,
    this.starSize = kBigIconSize + 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: onRatingChanged == null
              ? null
              : () {
                  onRatingChanged!(index + 1);
                },
          child: buildStar(context, index),
        );
      }),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border_rounded,
        color: emptyColor,
        size: starSize,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_rate_rounded,
        color: fullColor,
        size: starSize,
      );
    } else {
      icon = Icon(
        Icons.star_rate_rounded,
        color: fullColor,
        size: starSize,
      );
    }
    return icon;
  }
}
