import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

class OwnerPage extends StatefulWidget {
  const OwnerPage({super.key});

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  DateTimeRange? range;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 300,
            height: 400,
            child: RangeDatePicker(
              centerLeadingDate: true,
              minDate: DateTime(2020, 10, 10),
              maxDate: DateTime(2024, 10, 30),
              onRangeSelected: (value) {
                setState(() {
                  range = value;
                });
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              date = await showDatePickerDialog(
                context: context,
                minDate: range!.start,
                maxDate: range!.end,
              );
              setState(() {});
            },
            child: const Text('data'),
          ),
          //todo clean up this miss ,add date range to venue obj.
          TextButton(
            onPressed: () async {
              TimeOfDay? t = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              date = DateTime(date!.year, date!.month, date!.day, t!.hour);

              print(date!.hour);
              setState(() {});
            },
            child: const Text('data'),
          ),
          TextButton(
            onPressed: () => print(date),
            child: Text(date!.toString()),
          ),
          // range != null
          //     ? SizedBox(
          //         width: 300,
          //         height: 400,
          //         child: DatePicker(
          //           centerLeadingDate: true,
          //           minDate: range!.start,
          //           maxDate: range!.end,
          //           disabledCellsDecoration: const BoxDecoration(
          //             color: Colors.red,
          //           ),
          //           onDateSelected: (value) {
          //             date = value;
          //           },
          //         ),
          //       )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
