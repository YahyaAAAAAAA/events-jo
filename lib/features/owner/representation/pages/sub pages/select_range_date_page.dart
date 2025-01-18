import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
import 'package:flutter/material.dart';

//* This page lets the user pick between a range between 2 dates (REQUIRED)
class SelectRangeDatePage extends StatelessWidget {
  final DateTimeRange? range;
  final void Function(DateTimeRange)? onRangeSelected;

  const SelectRangeDatePage({
    super.key,
    required this.range,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const OwnerPageBar(),

          const SizedBox(height: 10),

          //date range
          SizedBox(
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
                color: GColors.royalBlue.withValues(alpha: 0.5),
              ),
              selectedCellsTextStyle: TextStyle(
                color: GColors.white,
                fontSize: 23,
              ),
              slidersColor: GColors.royalBlue,
              highlightColor: GColors.royalBlue.withValues(alpha: 0.2),
              splashColor: GColors.royalBlue.withValues(alpha: 0.2),
              singleSelectedCellDecoration: BoxDecoration(
                gradient: GColors.logoGradient,
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
          ),

          Center(
            child: Text(
              'Please pick your availability date',
              style: TextStyle(
                color: GColors.poloBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //display date range
          Center(
            child: Text(
              range != null
                  ? 'From ${range!.start.month}/${range!.start.day}/${range!.start.year} - To ${range!.end.month}/${range!.end.day}/${range!.end.year}'
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
