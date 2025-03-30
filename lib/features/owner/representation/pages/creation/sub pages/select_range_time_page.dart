import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/packages/from%20to%20picker/from_to_picker.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_bar.dart';
import 'package:flutter/material.dart';

//* This page lets the user pick between a range between 2 times (REQUIRED)
class SelectRangeTimePage extends StatelessWidget {
  final List<int> time;
  final int tempValueForTime;
  final dynamic Function(TimeOfDay, TimeOfDay)? onTab;

  const SelectRangeTimePage({
    super.key,
    required this.tempValueForTime,
    required this.time,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const OwnerPageBar(),

          const SizedBox(height: 100),

          //time range
          Center(
            child: FittedBox(
              child: FromToTimePicker(
                onTab: onTab,
                dialogBackgroundColor: GColors.poloBlue.withValues(alpha: 0.5),
                fromHeadlineColor: GColors.black,
                toHeadlineColor: GColors.black,
                timeBoxColor: GColors.royalBlue,
                upIconColor: GColors.white,
                downIconColor: GColors.white,
                dividerColor: GColors.poloBlue,
                timeTextColor: GColors.white,
                activeDayNightColor: GColors.royalBlue,
                dismissTextColor: GColors.redShade3,
                defaultDayNightColor: GColors.whiteShade3,
                doneTextColor: GColors.royalBlue,
                dismissText: '',
                showHeaderBullet: true,
                maxWidth: 500,
              ),
            ),
          ),

          Center(
            child: Text(
              'Please pick your open hours',
              style: TextStyle(
                color: GColors.poloBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //display time
          Center(
            child: Text(
              tempValueForTime != 0
                  ? 'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'
                  : '',
              style: TextStyle(
                color: GColors.royalBlue,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
