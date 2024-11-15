import 'dart:io';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_time_page.dart';
import 'package:events_jo/features/weddings/representation/components/venue_location_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerSpinnerPopUp extends StatefulWidget {
  const TimePickerSpinnerPopUp({
    Key? key,
    this.barrierColor = Colors.black12,
    this.backgroundColor = Colors.white,
    this.onChange,
    this.initTime,
    this.minTime,
    this.maxTime,
    this.paddingHorizontalOverlay,
    this.minuteInterval = 1,
    this.textStyle,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.iconSize = 18,
    this.padding = const EdgeInsets.fromLTRB(12, 10, 12, 10),
    this.cancelText = 'Cancel',
    this.confirmText = 'OK',
    this.isCancelTextLeft = false,
    this.enable = true,
    this.radius = 10,
    this.use24hFormat = true,
  }) : super(key: key);

  /// Barrier color when pop up show
  final Color barrierColor;

  /// Background color when pop up show
  final Color backgroundColor;

  /// A callback will call after user select DateTime
  final void Function(DateTime)? onChange;

  /// The initial date and/or time of the picker
  final DateTime? initTime;

  /// The minTime selectable date that the picker can settle on.
  final DateTime? minTime;

  /// The maximum selectable date that the picker can settle on.
  final DateTime? maxTime;

  /// Popup 's padding container
  final double? paddingHorizontalOverlay;

  /// The granularity of the minutes spinner, if it is shown in the current mode.
  /// Must be an integer factor of 60.
  final int minuteInterval;

  /// Time widget 's text style
  final TextStyle? textStyle;

  /// Time widget cancelTextStyle's text style
  final TextStyle? cancelTextStyle;

  /// Time widget confirmTextStyle's text style
  final TextStyle? confirmTextStyle;

  /// Time widget 's icon clock size
  final double iconSize;

  /// Time widget 's padding container
  final EdgeInsetsGeometry? padding;

  /// Text for cancel button, default is 'Cancel'
  final String cancelText;

  /// Text for confirm button, default is 'OK'
  final String confirmText;

  /// The position of [cancelText], default is right
  /// If [isCancelTextLeft] is true, [cancelText] will be on left
  final bool isCancelTextLeft;

  /// enable press to open the pop up or not, default is 'true'
  final bool enable;

  /// circular radius of the pop up, default is 10
  final double radius;

  /// Whether to use 24 hour format. Defaults to true.
  final bool use24hFormat;

  @override
  _TimePickerSpinnerPopUpState createState() => _TimePickerSpinnerPopUpState();
}

class _TimePickerSpinnerPopUpState extends State<TimePickerSpinnerPopUp>
    with SingleTickerProviderStateMixin {
  RenderBox? childBox;
  OverlayEntry? overlayEntry;

  late AnimationController animationController;
  late Tween<double> colorTween;
  late Animation<double?> animation;

  late DateTime selectedDateTime;
  late DateTime selectedDateTimeSpinner;

  double paddingHorizontal = 20;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initTime ?? DateTime.now();
    selectedDateTimeSpinner = widget.initTime ?? DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((call) {
      if (mounted) {
        childBox = context.findRenderObject() as RenderBox?;
      }
    });

    colorTween = Tween(begin: 0, end: 1);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animation = colorTween.animate(animationController);
  }

  @override
  void didUpdateWidget(covariant TimePickerSpinnerPopUp oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedDateTime = widget.initTime ?? DateTime.now();
    selectedDateTimeSpinner = widget.initTime ?? DateTime.now();
  }

  @override
  void dispose() {
    hideMenu();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return timeWidget();
    } else {
      return PopScope(
        onPopInvokedWithResult: (didPop, result) => hideMenu(),
        child: timeWidget(),
      );
    }
  }

  //row
  Widget timeWidget() {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //center text
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //todo add minutes
                Text(
                  'Your venue time: ' + selectedDateTime.hour.toString().toTime,
                  style: TextStyle(
                    fontSize: 25,
                    color: GColors.royalBlue,
                  ),
                ),
              ],
            ),
          ),
          //time
          VenueLocationButton(
            onPressed: !widget.enable ? null : () => showMenu(),
            icon: CustomIcons.calendar_clock,
            iconSize: 30,
            padding: 18,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  //dialog
  showMenu() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        final size = childBox!.size;
        final offset = childBox!.localToGlobal(const Offset(0, 0));

        if (widget.paddingHorizontalOverlay != null) {
          paddingHorizontal = widget.paddingHorizontalOverlay!;
        }

        final confirmButton = Expanded(
            child: GestureDetector(
          onTap: () {
            animationController.reverse();

            setState(() {
              selectedDateTime = selectedDateTimeSpinner;
            });

            Future.delayed(const Duration(milliseconds: 150), () {
              widget.onChange?.call(selectedDateTime);
              hideMenu();
            });
          },
          child: Text(
            widget.confirmText,
            style: widget.confirmTextStyle ??
                TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
            textAlign: TextAlign.center,
          ),
        ));

        final cancelButton = Expanded(
          child: GestureDetector(
            onTap: () {
              animationController.reverse();

              selectedDateTimeSpinner = selectedDateTime;
              Future.delayed(const Duration(milliseconds: 150), () {
                hideMenu();
              });
            },
            child: Text(
              widget.cancelText,
              style: widget.cancelTextStyle ??
                  TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        );

        Widget menu = Container(
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2), // changes position of shadow
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 225,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: size.width + 2 * paddingHorizontal,
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        minimumDate: widget.minTime,
                        maximumDate: widget.maxTime,
                        minuteInterval: widget.minuteInterval,
                        initialDateTime: selectedDateTimeSpinner,
                        use24hFormat: widget.use24hFormat,
                        backgroundColor: widget.backgroundColor,
                        onDateTimeChanged: (dateTime) {
                          if (widget.minTime != null &&
                              dateTime.isBefore(widget.minTime!)) {
                            selectedDateTimeSpinner = widget.minTime!;
                          } else if (widget.maxTime != null &&
                              dateTime.isAfter(widget.maxTime!)) {
                            selectedDateTimeSpinner = widget.maxTime!;
                          } else {
                            selectedDateTimeSpinner = dateTime;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(decoration: TextDecoration.none),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.isCancelTextLeft
                      ? [
                          cancelButton,
                          confirmButton,
                        ]
                      : [
                          confirmButton,
                          cancelButton,
                        ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );

        Widget menuWithPositioned = AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final value = animation.value ?? 0;

            final centerHorizontal = offset.dx + (size.width) / 2;

            double left = centerHorizontal -
                (((size.width) / 2 + paddingHorizontal) * value);
            double right = screenWidth -
                (centerHorizontal +
                    (((size.width) / 2 + paddingHorizontal) * value));
            double? top = offset.dy - ((220 / 2) * value);
            double? bottom;

            if (left < 0) {
              left = 5;
              right = screenWidth - (5 + size.width + 2 * paddingHorizontal);
            }

            if (right < 0) {
              right = 5;
              left = screenWidth - (5 + size.width + 2 * paddingHorizontal);
            }

            if (top < 0) {
              top = 5;
              bottom = null;
            }

            if (top + 240 > screenHeight) {
              bottom = 5;
              top = null;
            }

            return Positioned(
              left: left - 10,
              right: right - 10,
              top: top == null ? null : (top - 10),
              bottom: bottom == null ? null : (bottom - 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 270 * value,
                ),
                child: SingleChildScrollView(
                  child: menu,
                ),
              ),
            );
          },
        );

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  hideMenu();
                },
                child: Container(
                  color: widget.barrierColor,
                ),
              ),
            ),
            menuWithPositioned,
          ],
        );
      },
    );
    if (overlayEntry != null) {
      Overlay.of(context).insert(overlayEntry!);
      animationController.forward();
    }
  }

  hideMenu() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}
