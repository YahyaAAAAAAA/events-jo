import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:events_jo/features/owner/representation/components/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //logo icon
        GradientIcon(
          icon: CustomIcons.events_jo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),

        //logo text
        GradientText(
          'EventsJo for Owners',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          style: TextStyle(
            color: GColors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        //time range
        TimePicker(onTab: onTab),

        Text(
          'Please pick your open hours',
          style: TextStyle(
            color: GColors.poloBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        //display time
        Text(
          tempValueForTime != 0
              ? 'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'
              : '',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),

        const Spacer(flex: 2),
      ],
    );
  }
}

//extends string class to converts time from 24hr system to 12hr system
extension StringCasingExtension on String {
  String get toTime {
    if (int.parse(this) > 12) {
      return '${int.parse(this) - 12} PM';
    }

    if (int.parse(this) == 12) {
      return '12 PM';
    }

    if (int.parse(this) == 0) {
      return '12 AM';
    }
    return '$this AM';
  }
}
