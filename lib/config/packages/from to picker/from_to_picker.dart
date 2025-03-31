import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/packages/from%20to%20picker/from_to_picker_colors.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart';

///interactive from to hours picker
///
/// the returned result will be two 24h [TimeOfDay]
class FromToTimePicker extends StatefulWidget {
  /// return the two picked [TimeOfDay] values
  ///
  /// on user click on ok Button
  final Function(TimeOfDay, TimeOfDay)? onTab;

  final Function()? onCancelTab;

  /// add the limitation to the dialog width
  final double? maxWidth;

  /// the header of the dialog
  ///
  /// can provide user with information or available time to pick
  final String? headerText;

  /// the color of dialog header text
  final Color? headerTextColor;

  /// submit button text
  final String? doneText;

  /// submit button text color
  final Color? doneTextColor;

  /// dismiss button text color
  final Color? dismissTextColor;

  ///  dismiss button text
  final String? dismissText;

  ///  day text of both from to time  picker
  ///
  /// by default it must be 'AM'
  ///
  /// pass any text you want to localize it
  final String? dayText;

  /// the night text of both from to time picker
  ///
  /// by default it must be 'PM'
  ///
  /// pass any text you want to localize it
  final String? nightText;

  /// the default viewed text in time picker
  ///
  /// by default it contains '00'
  final String? timeHintText;

  /// the text above the first time picker
  final String? fromHeadline;

  /// the text above second time picker
  final String? toHeadline;

  /// color of text above the first time picker
  final Color? fromHeadlineColor;

  /// color of text above the first time picker
  final Color? toHeadlineColor;

  /// background color of Active 'AM','PM' box
  final Color? activeDayNightColor;

  /// background color of deactivated 'AM','PM' box
  final Color? defaultDayNightColor;

  /// text color of Active 'AM','PM' box
  final Color? activeDayNightTextColor;

  /// text color of deactivated 'AM','PM' box
  final Color? defaultDayNightTextColor;

  ///border radius of 'AM','PM' box
  final double? dayNightBorderRadius;

  ///border radius of time picker
  final double? timeBoxBorderRadius;

  /// background color of time picker
  final Color? timeBoxColor;

  /// background color of the dialog
  final Color? dialogBackgroundColor;

  /// icon of increasing time button
  final IconData? upIcon;

  /// icon of decreasing time button
  final IconData? downIcon;

  /// icon color of increasing time button
  final Color? upIconColor;

  /// icon color of decreasing time button
  final Color? downIconColor;

  /// color of the vertical divider between 'increasing and decreasing buttons' and 'the time text'
  final Color? dividerColor;

  /// color of default shown text in time box
  final Color? timeHintColor;

  /// color of picked hour text
  final Color? timeTextColor;

  /// show circular bullet before the dialog header
  ///
  /// can be used to show available or unavailable time to user
  final bool? showHeaderBullet;

  ///color of circular bullet before the dialog header
  ///
  /// for best practice use green color for available and red for unavailable time
  final Color? headerBulletColor;

  /// color of two dots separates between two time picker box
  final Color? colonColor;

  final int? initStartTime;

  final int? initEndTime;

  const FromToTimePicker(
      {Key? key,
      required this.onTab,
      this.initStartTime,
      this.initEndTime,
      this.onCancelTab,
      this.maxWidth,
      this.headerText,
      this.fromHeadline = 'From',
      this.toHeadline = 'To',
      this.fromHeadlineColor = FTTColors.black,
      this.toHeadlineColor = FTTColors.black,
      this.activeDayNightColor = FTTColors.primary_color,
      this.defaultDayNightColor = FTTColors.mainColor70,
      this.activeDayNightTextColor = FTTColors.white,
      this.defaultDayNightTextColor = FTTColors.black,
      this.dayNightBorderRadius = 5,
      this.timeBoxBorderRadius = 8,
      this.timeBoxColor = FTTColors.mainColor70,
      this.upIcon = Icons.keyboard_arrow_up_rounded,
      this.downIcon = Icons.keyboard_arrow_down_rounded,
      this.upIconColor = FTTColors.black,
      this.downIconColor = FTTColors.black,
      this.dividerColor = FTTColors.divider,
      this.timeHintColor = FTTColors.divider,
      this.timeTextColor = FTTColors.gray_66,
      this.doneText = 'ok',
      this.dismissText = 'cancel',
      this.dayText = 'AM',
      this.nightText = 'PM',
      this.dialogBackgroundColor = FTTColors.white,
      this.showHeaderBullet = false,
      this.headerBulletColor = FTTColors.green_1,
      this.headerTextColor = FTTColors.gray_9a,
      this.colonColor = FTTColors.black,
      this.timeHintText = '00',
      this.doneTextColor = FTTColors.black,
      this.dismissTextColor = FTTColors.dark_red})
      : super(key: key);

  @override
  State<FromToTimePicker> createState() => _FromToTimePickerState();
}

class _FromToTimePickerState extends State<FromToTimePicker> {
  bool isAmFrom = false, isAmTo = false;
  int timePickerStartTime = 0, timePickerEndTime = 0;
  late TimeOfDay fromTime;
  late TimeOfDay toTime;

  @override
  void initState() {
    super.initState();
    timePickerStartTime = widget.initStartTime ?? 0;
    timePickerEndTime = widget.initEndTime ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    Size originalScreenSize = MediaQuery.of(context).size;
    Size newScreenSize = Size(
        widget.maxWidth == null
            ? originalScreenSize.width
            : widget.maxWidth! < originalScreenSize.width
                ? widget.maxWidth!
                : originalScreenSize.width,
        originalScreenSize.height);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: newScreenSize.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: widget.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.headerText != null,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.showHeaderBullet!,
                          child: Container(
                            width: 12,
                            height: 12,
                            margin: EdgeInsetsDirectional.only(
                                end: newScreenSize.width * .02),
                            decoration: BoxDecoration(
                                color: widget.headerBulletColor,
                                borderRadius: BorderRadius.circular(
                                    newScreenSize.width * .04)),
                          ),
                        ),
                        Text(
                          '${widget.headerText}',
                          style: TextStyle(
                              fontSize: 12, color: widget.headerTextColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: newScreenSize.height * .03,
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fromTimeItem(widget.fromHeadline!, newScreenSize),
                    SizedBox(
                      width: newScreenSize.width * .04,
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          top: newScreenSize.height * .02),
                      height: newScreenSize.height * .12,
                      alignment: Alignment.center,
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: widget.colonColor),
                      ),
                    ),
                    SizedBox(
                      width: newScreenSize.width * .04,
                    ),
                    toTimeItem(widget.toHeadline!, newScreenSize)
                  ],
                ),
              ),
              SizedBox(
                height: newScreenSize.height * .04,
              ),
              Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            widget.dismissText!,
                            style: TextStyle(
                                color: widget.dismissTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        width: newScreenSize.width * .06,
                      ),
                      IconButton(
                        onPressed: widget.onCancelTab,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3,
                          ),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.all(12)),
                        ),
                        icon: Text(
                          'Cancel',
                          style: TextStyle(
                            color: widget.doneTextColor,
                            fontSize: kNormalFontSize,
                          ),
                        ),
                      ),
                      10.width,
                      IconButton(
                        onPressed: () {
                          widget.onTab!(
                              generate24HTime(
                                  isAmFrom, timePickerStartTime.toString()),
                              generate24HTime(
                                  isAmTo, timePickerEndTime.toString()));
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GColors.whiteShade3.shade600),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.all(12)),
                        ),
                        icon: Text(
                          widget.doneText!,
                          style: TextStyle(
                            color: widget.doneTextColor,
                            fontSize: kNormalFontSize,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  /// the from time part of the dialog
  ///
  /// contains two arrows, day night box, and time box
  Widget fromTimeItem(String headline, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(
              color: widget.fromHeadlineColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              fromTimePicker(size),
              SizedBox(
                width: size.width * .02,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAmFrom = true;
                        fromTime = generate24HTime(
                            isAmFrom, timePickerStartTime.toString());
                      });
                    },
                    child: Container(
                      width: size.width * .07,
                      height: size.height * .038,
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          widget.dayText!,
                          style: TextStyle(
                              color: isAmFrom
                                  ? widget.activeDayNightTextColor
                                  : widget.defaultDayNightTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: isAmFrom == true
                              ? widget.activeDayNightColor
                              : widget.defaultDayNightColor,
                          borderRadius: BorderRadiusDirectional.only(
                              topStart:
                                  Radius.circular(widget.dayNightBorderRadius!),
                              topEnd: Radius.circular(
                                  widget.dayNightBorderRadius!))),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .005,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAmFrom = false;
                        fromTime = generate24HTime(
                            isAmFrom, timePickerStartTime.toString());
                      });
                    },
                    child: Container(
                      width: size.width * .07,
                      height: size.height * .038,
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          widget.nightText!,
                          style: TextStyle(
                              color: isAmFrom
                                  ? widget.defaultDayNightTextColor
                                  : widget.activeDayNightTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: isAmFrom == true
                              ? widget.defaultDayNightColor
                              : widget.activeDayNightColor,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd:
                                  Radius.circular(widget.dayNightBorderRadius!),
                              bottomStart: Radius.circular(
                                  widget.dayNightBorderRadius!))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  /// the to time part of the dialog
  ///
  /// contains two arrows, day night box, and time box
  Widget toTimeItem(String headline, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(
              color: widget.toHeadlineColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              toTimePicker(size),
              SizedBox(
                width: size.width * .02,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAmTo = true;
                        toTime = generate24HTime(
                            isAmTo, timePickerEndTime.toString());
                      });
                    },
                    child: Container(
                      width: size.width * .07,
                      height: size.height * .038,
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          widget.dayText!,
                          style: TextStyle(
                              color: isAmTo
                                  ? widget.activeDayNightTextColor
                                  : widget.defaultDayNightTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: isAmTo == true
                              ? widget.activeDayNightColor
                              : widget.defaultDayNightColor,
                          borderRadius: BorderRadiusDirectional.only(
                              topStart:
                                  Radius.circular(widget.dayNightBorderRadius!),
                              topEnd: Radius.circular(
                                  widget.dayNightBorderRadius!))),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .005,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAmTo = false;
                        toTime = generate24HTime(
                            isAmTo, timePickerEndTime.toString());
                      });
                    },
                    child: Container(
                      width: size.width * .07,
                      height: size.height * .038,
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          widget.nightText!,
                          style: TextStyle(
                              color: isAmTo
                                  ? widget.defaultDayNightTextColor
                                  : widget.activeDayNightTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: isAmTo == true
                              ? widget.defaultDayNightColor
                              : widget.activeDayNightColor,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd:
                                  Radius.circular(widget.dayNightBorderRadius!),
                              bottomStart: Radius.circular(
                                  widget.dayNightBorderRadius!))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  /// from time box that contain arrows and picked hour text
  Widget fromTimePicker(Size size) {
    return Container(
      width: size.width * .20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.timeBoxBorderRadius!),
        color: widget.timeBoxColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: size.width * .01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor:
                          FTTColors.primary_color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (timePickerStartTime < 12) {
                          setState(() {
                            timePickerStartTime++;
                            fromTime = generate24HTime(
                                isAmFrom, timePickerStartTime.toString());
                          });
                        }
                      },
                      child: Container(
                        width: size.width * .06,
                        child: Icon(
                          widget.upIcon,
                          color: widget.upIconColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor:
                          FTTColors.primary_color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (timePickerStartTime > 1) {
                          setState(() {
                            timePickerStartTime--;
                            fromTime = generate24HTime(
                                isAmFrom, timePickerStartTime.toString());
                          });
                        }
                      },
                      child: Container(
                        width: size.width * .06,
                        child: Icon(
                          widget.downIcon,
                          color: widget.downIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * .01,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 2,
              color: widget.dividerColor,
            ),
            SizedBox(
              width: size.width * .01,
            ),
            Container(
              width: size.width * .10,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                    timePickerStartTime == 0
                        ? widget.timeHintText!
                        : timePickerStartTime.toString(),
                    key: ValueKey<String>(timePickerStartTime.toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: timePickerStartTime == 0
                            ? widget.timeHintColor
                            : widget.timeTextColor)),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// to time box that contain arrows and picked hour text
  Widget toTimePicker(Size size) {
    return Container(
      width: size.width * .20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.timeBoxBorderRadius!),
        color: widget.timeBoxColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: size.width * .01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor:
                          FTTColors.primary_color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (timePickerEndTime < 12) {
                          setState(() {
                            timePickerEndTime++;
                            toTime = generate24HTime(
                                isAmTo, timePickerEndTime.toString());
                          });
                        }
                      },
                      child: Container(
                        width: size.width * .06,
                        child: Icon(
                          widget.upIcon,
                          color: widget.upIconColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor:
                          FTTColors.primary_color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (timePickerEndTime > 1) {
                          setState(() {
                            timePickerEndTime--;
                            toTime = generate24HTime(
                                isAmTo, timePickerEndTime.toString());
                          });
                        }
                      },
                      child: Container(
                        width: size.width * .06,
                        child: Icon(
                          widget.downIcon,
                          color: widget.downIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * .01,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 2,
              color: widget.dividerColor,
            ),
            SizedBox(
              width: size.width * .01,
            ),
            Container(
                width: size.width * .10,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    timePickerEndTime == 0
                        ? widget.timeHintText!
                        : timePickerEndTime.toString(),
                    key: ValueKey<String>(timePickerEndTime.toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: timePickerEndTime == 0
                            ? widget.timeHintColor
                            : widget.timeTextColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  ///convert time from 12h to 24h format
  TimeOfDay generate24HTime(bool isAm, String hour) {
    initializeDateFormatting();
    DateTime date =
        DateFormat("hh:mma", 'en').parse("$hour:00${isAm ? 'AM' : 'PM'}");

    return TimeOfDay.fromDateTime(date);
  }

  ///check platform
  bool get isNotMobile {
    return defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows;
  }
}
