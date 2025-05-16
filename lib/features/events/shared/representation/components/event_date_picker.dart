import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class EventDatePicker extends StatelessWidget {
  final DateTime minDate;
  final DateTime maxDate;
  final void Function(DateTime)? onDateSelected;
  final List<DateTime>? reservedDates;
  final bool isDateAvailable;
  final double? width;
  final double? height;

  const EventDatePicker({
    super.key,
    required this.minDate,
    required this.maxDate,
    required this.onDateSelected,
    required this.reservedDates,
    required this.isDateAvailable,
    this.width = 250,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDateAvailable ? GColors.white : GColors.redShade3,
            width: 0.5,
          ),
        ),
        child: DatePicker(
          minDate: minDate,
          maxDate: maxDate,
          initialDate: minDate,
          // selectedDate: minDate,
          onDateSelected: onDateSelected,
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
          selectedCellDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
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
          selectedCellTextStyle: TextStyle(
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
          disabledDayPredicate: (date) {
            // if (reservedDates == null) {
            //   return false;
            // }
            // if (reservedDates!.isEmpty) {
            //   return false;
            // }
            // for (var reservedDate in reservedDates!) {
            //   if (date == reservedDate) {
            //     return true;
            //   }
            // }

            if (date.isBefore(DateTime.now())) {
              return true;
            }

            return false;
          },
        ),
      ),
    );
  }
}
