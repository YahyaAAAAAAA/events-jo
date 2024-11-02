import 'package:flutter/cupertino.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FromToTimePicker(
      onTab: (from, to) {
        // if (DateTime(0, 0, 0, from.hour).isBefore(
        //   DateTime(0, 0, 0, to.hour),
        // )) {

        //   time[0] = from.hour;
        //   time[1] = to.hour;
        // }
      },
    );
  }
}
