import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 400,
      child: RangeDatePicker(
        centerLeadingDate: true,
        minDate: DateTime(2020, 10, 10),
        maxDate: DateTime(2024, 10, 30),
        onRangeSelected: (value) {
          //range = value;
        },
      ),
    );
  }
}
