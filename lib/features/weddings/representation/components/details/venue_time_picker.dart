import 'dart:ui';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/representation/components/venue_details_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenueTimePicker extends StatelessWidget {
  final int minuteInterval;
  final double padding;
  final String text;
  final bool use24hFormat;

  final Color buttonColor;
  final Color backgroundColor;
  final Color timeColor;

  final DateTime? initTime;
  final DateTime? minTime;
  final DateTime? maxTime;

  final void Function(DateTime) onDateTimeChanged;
  final void Function()? confirmPressed;
  final void Function()? cancelPressed;

  const VenueTimePicker({
    super.key,
    required this.padding,
    required this.initTime,
    required this.maxTime,
    required this.minTime,
    required this.backgroundColor,
    required this.buttonColor,
    required this.timeColor,
    required this.minuteInterval,
    required this.use24hFormat,
    required this.onDateTimeChanged,
    required this.confirmPressed,
    required this.cancelPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 25,
                color: GColors.royalBlue,
              ),
            ),
            //time
            VenueDetailsButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: AlertDialog(
                          backgroundColor: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: SizedBox(
                            height: 225,
                            child: ScrollConfiguration(
                              //add drag behavior for cupertino widgets on Windows
                              behavior: const MaterialScrollBehavior().copyWith(
                                dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.stylus,
                                  PointerDeviceKind.unknown,
                                },
                              ),
                              child: CupertinoTheme(
                                data: CupertinoThemeData(
                                  textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: timeColor,
                                    ),
                                  ),
                                ),
                                child: CupertinoDatePicker(
                                  initialDateTime: initTime,
                                  maximumDate: maxTime,
                                  minimumDate: minTime,
                                  minuteInterval: minuteInterval,
                                  use24hFormat: use24hFormat,
                                  backgroundColor: backgroundColor,
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: onDateTimeChanged,
                                  //temp if (widget.minTime != null &&
                                  //     dateTime
                                  //         .isBefore(widget.minTime!)) {
                                  //   selectedDateTimeSpinner =
                                  //       widget.minTime!;
                                  // } else if (widget.maxTime != null &&
                                  //     dateTime.isAfter(widget.maxTime!)) {
                                  //   selectedDateTimeSpinner =
                                  //       widget.maxTime!;
                                  // } else {
                                  //   selectedDateTimeSpinner = dateTime;
                                  // }
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: cancelPressed,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(buttonColor),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: GColors.royalBlue,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: confirmPressed,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(buttonColor),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                  color: GColors.royalBlue,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: CustomIcons.calendar_clock,
              iconSize: 30,
              padding: 18,
            ),
          ],
        ),
      ),
      // child: TimePickerSpinnerPopUp(
      //   initTime: DateTime(0, 0, 0, weddingVenue.time[0], 0),
      //   minTime: DateTime(0, 0, 0, weddingVenue.time[0]),
      //   maxTime: DateTime(0, 0, 0, weddingVenue.time[1]),
      //   backgroundColor: GColors.whiteShade3,
      //   minuteInterval: 30,
      //   textStyle: TextStyle(color: GColors.royalBlue),
      //   confirmTextStyle: TextStyle(color: GColors.royalBlue),
      //   cancelTextStyle: TextStyle(color: GColors.royalBlue),
      //   radius: 12,
      //   padding: EdgeInsets.all(padding),
      //   paddingHorizontalOverlay: BorderSide.strokeAlignCenter,
      //   use24hFormat: false,
      //   cancelText: 'Cancel',
      //   confirmText: 'OK',
      //   onChange: onChange,
      // ),
    );
  }
}
