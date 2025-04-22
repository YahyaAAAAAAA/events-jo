import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/datetime_range_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/dummy.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/courts/representation/cubits/single%20court/single_football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/single%20court/single_football_court_states.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/events/shared/representation/components/event_image_slider.dart';
import 'package:events_jo/features/events/shared/representation/components/event_date_picker.dart';
import 'package:events_jo/features/events/shared/representation/components/event_time_picker.dart';
import 'package:events_jo/features/events/shared/representation/components/event_rate.dart';
import 'package:events_jo/features/events/shared/representation/components/events_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FootballCourtsDetailsPage extends StatefulWidget {
  final AppUser? user;
  final FootballCourt footballCourt;

  const FootballCourtsDetailsPage({
    super.key,
    required this.user,
    required this.footballCourt,
  });

  @override
  State<FootballCourtsDetailsPage> createState() =>
      _FootballCourtsDetailsPageState();
}

class _FootballCourtsDetailsPageState extends State<FootballCourtsDetailsPage> {
  //current venue
  late final FootballCourt footballCourt;

  late final SingleFootballCourtCubit singleFootballCourtCubit;
  late final OrderCubit orderCubit;

  //venue location
  late final EjLocation venueLocation;

  //time
  late DateTime selectedStartTime;
  late DateTime selectedStartTimeInit;
  late DateTime selectedEndTime;
  late DateTime selectedEndTimeInit;
  int numberOfExpectedPeople = 0;

  int currnetRating = 0;
  double totalAmount = 0;
  String paymentMethod = 'cash';
  DateTime? selectedDate;
  List<DateTimeRange>? reservedDates = [];

  @override
  void initState() {
    super.initState();

    //get venue
    footballCourt = widget.footballCourt;

    //get cubits
    singleFootballCourtCubit = context.read<SingleFootballCourtCubit>();
    orderCubit = context.read<OrderCubit>();

    //setup time
    selectedStartTime = DateTime(0, 0, 0, footballCourt.time[0]);
    selectedStartTimeInit = DateTime(0, 0, 0, footballCourt.time[0]);
    selectedEndTime = DateTime(0, 0, 0, footballCourt.time[1]);
    selectedEndTimeInit = DateTime(0, 0, 0, footballCourt.time[1]);

    //get venue location
    venueLocation = EjLocation(
      lat: footballCourt.latitude,
      long: footballCourt.longitude,
      initLat: footballCourt.latitude,
      initLong: footballCourt.longitude,
    );

    currnetRating = singleFootballCourtCubit.getCurrentUserRate(
        footballCourt.rates, widget.user!.uid);

    //listen to venue
    singleFootballCourtCubit.getCourt(footballCourt.id);
    getVenueOrders();
  }

  void getVenueOrders() async {
    reservedDates = await orderCubit.getVenueReservedDates(footballCourt.id);
    setState(() {});
  }

  bool isDateAvailable() {
    if (reservedDates == null) {
      return true;
    }

    if (selectedDate == null) {
      return true;
    }

    DateTime start = selectedDate!.add(Duration(hours: selectedStartTime.hour));
    DateTime end = selectedDate!.add(Duration(hours: selectedEndTime.hour));
    DateTimeRange range = DateTimeRange(start: start, end: end);

    for (int i = 0; i < reservedDates!.length; i++) {
      if (reservedDates![i].conflictsWith(range)) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* title
      appBar: EventsAppBar(
        eventName: footballCourt.name,
        onRatePressed: () => showModalBottomSheet(
          context: context,
          backgroundColor: GColors.whiteShade3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(kOuterRadius),
            ),
          ),
          showDragHandle: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(12),
            child: StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      'How do you rate ${footballCourt.name} ?',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                      ),
                    ),
                    EventRate(
                      rating: currnetRating,
                      fullColor: GColors.fullRate,
                      emptyColor: GColors.emptyRate,
                      onRatingChanged: (value) {
                        setState(() {
                          currnetRating = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(GColors.whiteShade3),
                          ),
                          icon: Text(
                            'Cancel',
                            style: TextStyle(
                              color: GColors.royalBlue,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            int count = await orderCubit.getUserOrdersCount(
                                widget.user!.uid, footballCourt.id);

                            await singleFootballCourtCubit.rateVenue(
                              courtId: footballCourt.id,
                              userId: widget.user!.uid,
                              userName: widget.user?.name ?? 'User 123',
                              userOrdersCount: count,
                              rate: currnetRating,
                            );
                            context.pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                GColors.whiteShade3.shade600),
                          ),
                          icon: Text(
                            'Submit',
                            style: TextStyle(
                              color: GColors.royalBlue,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child:
              BlocConsumer<SingleFootballCourtCubit, SingleFootballCourtStates>(
            listener: (context, state) {
              if (state is SingleFootballCourtError) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              if (state is SingleFootballCourtLoaded) {
                final court = state.court;

                return buildVenueElements(context, court);
              } else {
                return Skeletonizer(
                    enabled: true,
                    containersColor: GColors.white,
                    child: buildVenueElements(context, Dummy.court));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width >= 288
          ? Container(
              decoration: BoxDecoration(
                color: GColors.whiteShade3.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kOuterRadius),
                  topRight: Radius.circular(kOuterRadius),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: IconButton(
                onPressed: () {
                  if (selectedDate == null) {
                    context.showSnackBar('Please pick a date');
                    return;
                  }
                  if (!isDateAvailable()) {
                    context
                        .showSnackBar('Please pick a different date or time');
                    return;
                  }
                  orderCubit.showCashoutSheet(
                    context: context,
                    userId: widget.user!.uid,
                    venueId: footballCourt.id,
                    ownerId: footballCourt.ownerId,
                    date: selectedDate,
                    startTime: selectedStartTime.hour,
                    endTime: selectedEndTime.hour,
                    people: numberOfExpectedPeople,
                    paymentMethod: paymentMethod,
                    totalAmount: totalAmount,
                    meals: [],
                    drinks: [],
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.all(12),
                  ),
                ),
                icon: Row(
                  children: [
                    Icon(
                      Icons.checklist_rtl_outlined,
                      color: GColors.white,
                      size: kNormalIconSize,
                    ),
                    10.width,
                    Text(
                      'Done? Checkout now',
                      style: TextStyle(
                        color: GColors.white,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<SingleFootballCourtCubit,
                        SingleFootballCourtStates>(builder: (context, state) {
                      if (state is SingleFootballCourtLoaded) {
                        final court = state.court;

                        return SizedBox(
                          width: 80,
                          child: Text(
                            'JOD ${(court.pricePerHour * (selectedEndTime.hour - selectedStartTime.hour)).toDouble()}',
                            style: TextStyle(
                              color: GColors.white,
                              fontSize: kSmallFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      } else {
                        return Text(
                          'JOD 0.0',
                          style: TextStyle(
                            color: GColors.white,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            )
          : 0.width,
    );
  }

  ListView buildVenueElements(
      BuildContext context, FootballCourt footballCourt) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        //* images slider
        EventImageSlider(
          picsList: singleFootballCourtCubit.stringsToImages(
            footballCourt.pics,
          ),
          event: footballCourt,
          eventLocation: venueLocation,
        ),

        5.height,
        eventText('The date of your booking'),

        //* date
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDatePicker(
                width: 450,
                minDate: DateTime(
                  footballCourt.startDate[0],
                  footballCourt.startDate[1],
                  footballCourt.startDate[2],
                ),
                maxDate: DateTime(
                  footballCourt.endDate[0],
                  footballCourt.endDate[1],
                  footballCourt.endDate[2],
                ),
                //save date
                onDateSelected: (date) => setState(
                  () => selectedDate = date,
                ),
                reservedDates: null,
                isDateAvailable: isDateAvailable(),
              ),
              5.height,
              eventText('The time of your booking'),
              Container(
                decoration: BoxDecoration(
                  color: GColors.white,
                  borderRadius: BorderRadius.circular(kOuterRadius),
                  border: Border.all(
                    color:
                        isDateAvailable() ? GColors.white : GColors.redShade3,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    EventTimePicker(
                      text: 'Start',
                      icon: CustomIcons.calendar,
                      backgroundColor: GColors.whiteShade3,
                      buttonColor: GColors.white,
                      timeColor: GColors.royalBlue,
                      initTime: selectedStartTime,
                      minTime: DateTime(0, 0, 0, footballCourt.time[0]),
                      maxTime: DateTime(0, 0, 0, footballCourt.time[1]),
                      minuteInterval: 10,
                      use24hFormat: false,
                      //waits for confirmation
                      onDateTimeChanged: (date) {
                        selectedStartTimeInit = date;
                      },
                      //saves selected time
                      confirmPressed: () {
                        if (!selectedEndTime.isAfter(selectedStartTimeInit)) {
                          context
                              .showSnackBar('Please pick a valid start time');
                          Navigator.of(context).pop();
                          return;
                        }
                        setState(() {
                          selectedStartTime = selectedStartTimeInit;
                          Navigator.of(context).pop();
                        });
                      },
                      //do nothing
                      cancelPressed: () => Navigator.of(context).pop(),
                    ),

                    const SizedBox(
                      height: 50,
                      child: VerticalDivider(),
                    ),

                    //* time
                    EventTimePicker(
                      text: 'Finish',
                      icon: CustomIcons.calendar_clock,
                      backgroundColor: GColors.whiteShade3,
                      buttonColor: GColors.white,
                      timeColor: GColors.royalBlue,
                      initTime: selectedEndTime,
                      minTime: DateTime(0, 0, 0, footballCourt.time[0]),
                      maxTime: DateTime(0, 0, 0, footballCourt.time[1]),
                      minuteInterval: 10,
                      use24hFormat: false,
                      //waits for confirmation
                      onDateTimeChanged: (date) => selectedEndTimeInit = date,
                      //saves selected time
                      confirmPressed: () {
                        if (selectedStartTime.isAfter(selectedEndTimeInit)) {
                          context
                              .showSnackBar('Please pick a valid finish time');
                          Navigator.of(context).pop();
                          return;
                        }
                        setState(() {
                          selectedEndTime = selectedEndTimeInit;
                          Navigator.of(context).pop();
                        });
                      },
                      //do nothing
                      cancelPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              eventText('Pricing'),
              5.height,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: GColors.white,
                  borderRadius: BorderRadius.circular(kOuterRadius),
                  border: Border.all(
                    color:
                        isDateAvailable() ? GColors.white : GColors.redShade3,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3.shade600),
                      ),
                      icon: Icon(
                        Icons.attach_money_rounded,
                        size: kNormalIconSize,
                        color: GColors.royalBlue,
                      ),
                    ),
                    5.width,
                    Text(
                      'Price Per Hour: JOD ${footballCourt.pricePerHour}',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget eventText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          color: GColors.black,
          fontSize: kSmallFontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
