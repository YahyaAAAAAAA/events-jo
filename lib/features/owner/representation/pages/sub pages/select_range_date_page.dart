import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/date_picker.dart';
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
        shrinkWrap: true,
        children: [
          const SizedBox(height: 100),

          //date range
          DatePicker(
            onRangeSelected: onRangeSelected,
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
        ],
      ),
    );
  }
}
