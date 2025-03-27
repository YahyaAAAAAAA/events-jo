import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueDatePicker extends StatelessWidget {
  final DateTime minDate;
  final DateTime maxDate;
  final void Function(DateTime)? onDateSelected;

  const VenueDatePicker({
    super.key,
    required this.minDate,
    required this.maxDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DatePicker(
          minDate: minDate,
          maxDate: maxDate,
          initialDate: minDate,
          selectedDate: minDate,
          onDateSelected: onDateSelected,
          currentDateDecoration: BoxDecoration(
            border: Border.all(
              color: GColors.royalBlue,
            ),
            borderRadius: BorderRadius.circular(50),
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
        ),
      ),
    );
  }
}
