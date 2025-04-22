import 'dart:ui';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventTimePicker extends StatelessWidget {
  final int minuteInterval;
  final String text;
  final bool use24hFormat;

  final Color buttonColor;
  final Color backgroundColor;
  final Color timeColor;
  final IconData icon;

  final DateTime? initTime;
  final DateTime? minTime;
  final DateTime? maxTime;

  final void Function(DateTime) onDateTimeChanged;
  final void Function()? confirmPressed;
  final void Function()? cancelPressed;

  const EventTimePicker({
    super.key,
    required this.initTime,
    required this.maxTime,
    required this.minTime,
    required this.backgroundColor,
    required this.buttonColor,
    required this.timeColor,
    required this.icon,
    required this.minuteInterval,
    required this.use24hFormat,
    required this.onDateTimeChanged,
    required this.confirmPressed,
    required this.cancelPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(GColors.whiteShade3.shade600),
            ),
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
            icon: Icon(
              icon,
              size: kSmallIconSize,
              color: GColors.royalBlue,
            ),
          ),
          5.width,
          //time
          Text(
            '$text at: ' +
                initTime!.hour
                    .toString()
                    .toTimeWithMinutes(initTime!.minute.toString()),
            style: TextStyle(
              fontSize: kSmallFontSize - 2,
              color: GColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
