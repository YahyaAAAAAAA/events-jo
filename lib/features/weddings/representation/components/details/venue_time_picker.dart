import 'package:events_jo/config/packages/time_picker_spinner/time_picker_spinner_popup.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';

class VenueTimePicker extends StatelessWidget {
  final WeddingVenue weddingVenue;
  final double padding;
  final void Function(DateTime)? onChange;

  const VenueTimePicker({
    super.key,
    required this.weddingVenue,
    required this.padding,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TimePickerSpinnerPopUp(
        initTime: DateTime(0, 0, 0, weddingVenue.time[0], 0),
        minTime: DateTime(0, 0, 0, weddingVenue.time[0]),
        maxTime: DateTime(0, 0, 0, weddingVenue.time[1]),
        backgroundColor: GColors.whiteShade3,
        minuteInterval: 30,
        textStyle: TextStyle(color: GColors.royalBlue),
        confirmTextStyle: TextStyle(color: GColors.royalBlue),
        cancelTextStyle: TextStyle(color: GColors.royalBlue),
        radius: 12,
        padding: EdgeInsets.all(padding),
        paddingHorizontalOverlay: BorderSide.strokeAlignCenter,
        use24hFormat: false,
        cancelText: 'Cancel',
        confirmText: 'OK',
        onChange: onChange,
      ),
    );
  }
}
