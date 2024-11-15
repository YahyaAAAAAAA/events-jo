import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';

class VenueDatePicker extends StatelessWidget {
  final WeddingVenue weddingVenue;

  const VenueDatePicker({
    super.key,
    required this.weddingVenue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 320,
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DatePicker(
        minDate: DateTime(
          weddingVenue.startDate[0],
          weddingVenue.startDate[1],
          weddingVenue.startDate[2],
        ),
        maxDate: DateTime(
          weddingVenue.endDate[0],
          weddingVenue.endDate[1],
          weddingVenue.endDate[2],
        ),
        currentDateDecoration: BoxDecoration(
          border: Border.all(
            color: GColors.royalBlue,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        slidersColor: GColors.royalBlue,
        highlightColor: GColors.royalBlue.withOpacity(0.2),
        splashColor: GColors.royalBlue.withOpacity(0.2),
        selectedCellDecoration: BoxDecoration(
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
