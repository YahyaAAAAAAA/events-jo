import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:events_jo/features/owner/representation/components/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class SelectRangeDate extends StatelessWidget {
  final void Function(DateTimeRange)? onRangeSelected;
  const SelectRangeDate({
    super.key,
    required this.range,
    required this.onRangeSelected,
  });

  final DateTimeRange? range;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),
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
        DatePicker(
          onRangeSelected: onRangeSelected,
        ),
        Text(
          'Please pick your availability date',
          style: TextStyle(
            color: GColors.poloBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          range != null
              ? 'From ${range!.start.month}/${range!.start.day}/${range!.start.year} - To ${range!.end.month}/${range!.end.day}/${range!.end.year}'
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
