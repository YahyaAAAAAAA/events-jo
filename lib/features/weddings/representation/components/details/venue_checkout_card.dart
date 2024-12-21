import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueCheckoutCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? trailing;

  const VenueCheckoutCard({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: GColors.white,
      child: ListTile(
          // titleAlignment: ListTileTitleAlignment.titleHeight,

          title: Text(
            title ?? ' ',
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle ?? '',
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 18,
                  ),
                )
              : null,
          trailing: trailing),
    );
  }
}
