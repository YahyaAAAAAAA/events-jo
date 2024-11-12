import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* This widget let you pick between a range between 2 dates
class DatePicker extends StatelessWidget {
  final void Function(DateTimeRange)? onRangeSelected;
  const DatePicker({
    super.key,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: RangeDatePicker(
        centerLeadingDate: true,
        //min date is todays date
        minDate: DateTime.now(),
        //max date is a year form now
        maxDate: DateTime.now().add(const Duration(days: 365)),
        //range select
        onRangeSelected: onRangeSelected,
        //styling down
        selectedCellsDecoration: BoxDecoration(
          color: GColors.royalBlue.withOpacity(0.5),
        ),
        selectedCellsTextStyle: TextStyle(
          color: GColors.white,
          fontSize: 23,
        ),
        slidersColor: GColors.royalBlue,
        highlightColor: GColors.royalBlue.withOpacity(0.2),
        splashColor: GColors.royalBlue.withOpacity(0.2),
        singleSelectedCellDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GColors.logoGradient,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        daysOfTheWeekTextStyle: TextStyle(
          color: GColors.poloBlue,
        ),
        leadingDateTextStyle: TextStyle(
          color: GColors.royalBlue,
          fontSize: 21,
        ),
      ),
    );
  }
}
