import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* This page lets the user pick between a range between 2 dates (REQUIRED)
class SelectRangeDatePage extends StatelessWidget {
  final EventType eventType;
  final DateTimeRange? range;
  final void Function(DateTimeRange)? onRangeSelected;
  final void Function()? testPress;

  const SelectRangeDatePage({
    super.key,
    required this.eventType,
    required this.range,
    required this.onRangeSelected,
    this.testPress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          GestureDetector(
            onTap: testPress,
            child: Text(
              'Select dates where your ${eventType.name} would be open',
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              // width: 250,
              height: 250,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kOuterRadius),
                color: GColors.white,
              ),
              child: RangeDatePicker(
                centerLeadingDate: true,
                //min date is todays date
                minDate: DateTime.now(),
                //max date is a year form now
                maxDate: DateTime.now().add(const Duration(days: 365)),
                //range select
                onRangeSelected: onRangeSelected,
                //styling down
                splashRadius: 15,
                currentDateDecoration: BoxDecoration(
                  border: Border.all(
                    color: GColors.royalBlue,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                slidersColor: GColors.black,
                slidersSize: kSmallIconSize,
                highlightColor: GColors.royalBlue.withValues(alpha: 0.2),
                splashColor: GColors.royalBlue.withValues(alpha: 0.2),
                selectedCellsDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: GColors.whiteShade3.shade600,
                ),
                daysOfTheWeekTextStyle: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize - 2,
                ),
                leadingDateTextStyle: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
                enabledCellsTextStyle: TextStyle(
                  fontSize: kSmallFontSize,
                  color: GColors.black,
                ),
                selectedCellsTextStyle: TextStyle(
                  fontSize: kSmallFontSize,
                  color: GColors.royalBlue,
                ),
                disabledCellsTextStyle: TextStyle(
                  fontSize: kSmallFontSize,
                  color: GColors.black.withValues(alpha: 0.5),
                ),
                currentDateTextStyle: TextStyle(
                  fontSize: kSmallFontSize,
                  color: GColors.black,
                ),
                singleSelectedCellTextStyle: TextStyle(
                  color: GColors.white,
                  fontSize: kSmallFontSize,
                ),
                singleSelectedCellDecoration: BoxDecoration(
                  color: GColors.royalBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
