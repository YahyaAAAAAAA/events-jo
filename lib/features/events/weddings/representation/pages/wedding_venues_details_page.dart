import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/datetime_range_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/dummy.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/chat/representation/pages/chat_page.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/events/weddings/representation/components/drink_card.dart';
import 'package:events_jo/features/events/weddings/representation/components/empty_card.dart';
import 'package:events_jo/features/events/weddings/representation/components/meal_card.dart';
import 'package:events_jo/features/events/shared/representation/components/event_image_slider.dart';
import 'package:events_jo/features/events/shared/representation/components/event_date_picker.dart';
import 'package:events_jo/features/events/weddings/representation/components/details/venue_people_slider.dart';
import 'package:events_jo/features/events/shared/representation/components/event_time_picker.dart';
import 'package:events_jo/features/events/shared/representation/components/event_rate.dart';
import 'package:events_jo/features/events/shared/representation/components/events_app_bar.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/single%20venue/single_wedding_venue_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/single%20venue/single_wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeddingVenuesDetailsPage extends StatefulWidget {
  final AppUser? user;
  final WeddingVenue weddingVenue;

  const WeddingVenuesDetailsPage({
    super.key,
    required this.user,
    required this.weddingVenue,
  });

  @override
  State<WeddingVenuesDetailsPage> createState() =>
      _WeddingVenuesDetailsPageState();
}

class _WeddingVenuesDetailsPageState extends State<WeddingVenuesDetailsPage> {
  //current venue
  late final WeddingVenue weddingVenue;

  late final SingleWeddingVenueCubit singleWeddingVenueCubit;
  late final OrderCubit orderCubit;

  //venue location
  late final LocationCubit locationCubit;
  late final EjLocation venueLocation;

  //time
  late DateTime selectedStartTime;
  late DateTime selectedStartTimeInit;
  late DateTime selectedEndTime;
  late DateTime selectedEndTimeInit;
  late int numberOfExpectedPeople;

  int currnetRating = 0;
  double totalAmount = 0;
  String paymentMethod = 'cash';
  DateTime? selectedDate;
  List<WeddingVenueMeal>? selectedMeals = [];
  List<WeddingVenueDrink>? selectedDrinks = [];
  List<DateTimeRange>? reservedDates = [];
  bool isRefundable = false;

  @override
  void initState() {
    super.initState();

    //get venue
    weddingVenue = widget.weddingVenue;

    //get cubits
    singleWeddingVenueCubit = context.read<SingleWeddingVenueCubit>();
    orderCubit = context.read<OrderCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup time
    selectedStartTime = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedStartTimeInit = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedEndTime = DateTime(0, 0, 0, weddingVenue.time[1]);
    selectedEndTimeInit = DateTime(0, 0, 0, weddingVenue.time[1]);

    //setup people range
    numberOfExpectedPeople = weddingVenue.peopleMin;

    //get venue location
    venueLocation = EjLocation(
      lat: weddingVenue.latitude,
      long: weddingVenue.longitude,
      initLat: weddingVenue.latitude,
      initLong: weddingVenue.longitude,
    );

    currnetRating = singleWeddingVenueCubit.getCurrentUserRate(
        weddingVenue.rates, widget.user!.uid);

    //listen to venue
    singleWeddingVenueCubit.getDetailedVenue(weddingVenue.id);
    getVenueOrders();
  }

  double getTotalPrice({
    required List<WeddingVenueMeal> meals,
    required List<WeddingVenueDrink> drinks,
    required double peoplePrice,
    required double numberOfPeople,
  }) {
    double total = 0;
    //calculate total meals
    for (int i = 0; i < meals.length; i++) {
      total += meals[i].calculatedPrice;
    }
    //calculate total drinks
    for (int i = 0; i < drinks.length; i++) {
      total += drinks[i].calculatedPrice;
    }
    //calculate total price for people
    total += (numberOfPeople * peoplePrice);

    totalAmount = total;
    selectedMeals = meals.map((meal) => meal.copyWith()).toList();
    selectedDrinks = drinks.map((drink) => drink.copyWith()).toList();
    for (int i = 0; i < selectedMeals!.length; i++) {
      selectedMeals![i].amount = meals[i].selectedAmount;
    }

    for (int i = 0; i < selectedDrinks!.length; i++) {
      selectedDrinks![i].amount = drinks[i].selectedAmount;
    }
    return total;
  }

  void getVenueOrders() async {
    reservedDates = await orderCubit.getVenueReservedDates(weddingVenue.id);

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
        eventName: weddingVenue.name,
        onChatPressed: () => widget.user!.uid != weddingVenue.ownerId
            ? context.push(
                ChatPage(
                  currentUserId: widget.user!.uid,
                  otherUserId: weddingVenue.ownerId,
                  currentUserName: widget.user!.name,
                  otherUserName: weddingVenue.ownerName,
                ),
              )
            : context.showSnackBar('You can\'t chat with yourself'),
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
                      'How do you rate ${weddingVenue.name} ?',
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
                                widget.user!.uid, weddingVenue.id);

                            await singleWeddingVenueCubit.rateVenue(
                              venueId: weddingVenue.id,
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
              BlocConsumer<SingleWeddingVenueCubit, SingleWeddingVenueStates>(
            listener: (context, state) {
              if (state is SingleWeddingVenueError) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              if (state is SingleWeddingVenueLoaded) {
                final venue = state.data.venue;
                final meals = state.data.meals;
                final drinks = state.data.drinks;

                return buildVenueElements(context, venue, meals, drinks);
              } else {
                return Skeletonizer(
                    enabled: true,
                    containersColor: GColors.white,
                    child: buildVenueElements(context, Dummy.venue, [], []));
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
                    eventType: EventType.venue,
                    userId: widget.user!.uid,
                    venueId: weddingVenue.id,
                    ownerId: weddingVenue.ownerId,
                    date: selectedDate,
                    startTime: selectedStartTime.hour,
                    endTime: selectedEndTime.hour,
                    people: numberOfExpectedPeople,
                    paymentMethod: paymentMethod,
                    totalAmount: totalAmount,
                    meals: selectedMeals!,
                    drinks: selectedDrinks!,
                    isRefundable: isRefundable,
                    stripeAccountId: weddingVenue.stripeAccountId,
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
                    BlocBuilder<SingleWeddingVenueCubit,
                        SingleWeddingVenueStates>(builder: (context, state) {
                      if (state is SingleWeddingVenueLoaded) {
                        final venue = state.data.venue;
                        final meals = state.data.meals;
                        final drinks = state.data.drinks;
                        final selectedMeals = meals
                            .where(
                              (element) => element.isChecked,
                            )
                            .toList();
                        final selectedDrinks = drinks
                            .where(
                              (element) => element.isChecked,
                            )
                            .toList();
                        return SizedBox(
                          width: 80,
                          child: Text(
                            'JOD ' +
                                getTotalPrice(
                                  meals: selectedMeals,
                                  drinks: selectedDrinks,
                                  peoplePrice: venue.peoplePrice,
                                  numberOfPeople:
                                      numberOfExpectedPeople.toDouble(),
                                ).toString(),
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

  ListView buildVenueElements(BuildContext context, WeddingVenue venue,
      List<WeddingVenueMeal> meals, List<WeddingVenueDrink> drinks) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        //* images slider
        EventImageSlider(
          picsList: singleWeddingVenueCubit.stringsToImages(
            venue.pics.isEmpty ? [kPlaceholderImage] : venue.pics,
          ),
          event: venue,
          eventLocation: venueLocation,
        ),

        5.height,

        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              venueText('The date you want to book'),
              100.width,
              venueText('The time for your venue'),
            ],
          ),
        ),

        //* date
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDatePicker(
                minDate: DateTime(
                  venue.startDate[0],
                  venue.startDate[1],
                  venue.startDate[2],
                ),
                maxDate: DateTime(
                  venue.endDate[0],
                  venue.endDate[1],
                  venue.endDate[2],
                ),
                //save date
                onDateSelected: (date) => setState(
                  () => selectedDate = date,
                ),
                reservedDates: null,
                isDateAvailable: isDateAvailable(),
              ),
              5.width,
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: BorderRadius.circular(kOuterRadius),
                      border: Border.all(
                        color: isDateAvailable()
                            ? GColors.white
                            : GColors.redShade3,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        EventTimePicker(
                          text: 'Start',
                          icon: CustomIcons.calendar,
                          backgroundColor: GColors.whiteShade3,
                          buttonColor: GColors.white,
                          timeColor: GColors.royalBlue,
                          initTime: selectedStartTime,
                          minTime: DateTime(0, 0, 0, venue.time[0]),
                          maxTime: DateTime(0, 0, 0, venue.time[1]),
                          minuteInterval: 10,
                          use24hFormat: false,
                          //waits for confirmation
                          onDateTimeChanged: (date) {
                            selectedStartTimeInit = date;
                          },
                          //saves selected time
                          confirmPressed: () {
                            if (!selectedEndTime
                                .isAfter(selectedStartTimeInit)) {
                              context.showSnackBar(
                                  'Please pick a valid start time');
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
                          width: 140,
                          child: Divider(),
                        ),

                        //* time
                        EventTimePicker(
                          text: 'Finish',
                          icon: CustomIcons.calendar_clock,
                          backgroundColor: GColors.whiteShade3,
                          buttonColor: GColors.white,
                          timeColor: GColors.royalBlue,
                          initTime: selectedEndTime,
                          minTime: DateTime(0, 0, 0, venue.time[0]),
                          maxTime: DateTime(0, 0, 0, venue.time[1]),
                          minuteInterval: 10,
                          use24hFormat: false,
                          //waits for confirmation
                          onDateTimeChanged: (date) =>
                              selectedEndTimeInit = date,
                          //saves selected time
                          confirmPressed: () {
                            if (selectedStartTime
                                .isAfter(selectedEndTimeInit)) {
                              context.showSnackBar(
                                  'Please pick a valid finish time');
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
                  venueText('Number of expected people'),
                  Container(
                    width: 160,
                    height: 65,
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: BorderRadius.circular(kOuterRadius),
                    ),
                    child: VenuePeopleSlider(
                      max: venue.peopleMax,
                      min: venue.peopleMin,
                      numberOfExpectedPeople: numberOfExpectedPeople,
                      pricePerPerson: venue.peoplePrice,
                      onChanged: (value) => setState(
                        () => numberOfExpectedPeople = value.toInt(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        venueText('Select your preferred meals'),

        //* meals
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: meals.isNotEmpty ? meals.length : 1,
          //add gap between children
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          //build meals
          itemBuilder: (context, index) {
            return meals.isNotEmpty
                ? MealCard(
                    isChecked: meals[index].isChecked,
                    amount: meals[index].amount,
                    price: meals[index].price,
                    selectedAmount: meals[index].selectedAmount,
                    name: meals[index].name,
                    calculatedPrice: meals[index].calculatedPrice,
                    //check & uncheck meal
                    onCheckBoxChanged: (value) => setState(
                      () => meals[index].isChecked = !meals[index].isChecked,
                    ),
                    //change meal amount
                    onSliderChanged: (value) =>
                        singleWeddingVenueCubit.calculateIndividualMealsPrice(
                      meals[index],
                      value,
                    ),
                  )
                : EmptyCard(
                    text: 'No meals available for ${venue.name}',
                  );
          },
        ),

        10.height,

        venueText('Select your preferred drinks'),

        //* drinks
        ListView.separated(
          //note: this is how to put listview inside a column
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: drinks.isNotEmpty ? drinks.length : 1,
          //add gap between children
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          //build meals
          itemBuilder: (context, index) {
            return drinks.isNotEmpty
                ? DrinkCard(
                    isChecked: drinks[index].isChecked,
                    amount: drinks[index].amount,
                    price: drinks[index].price,
                    selectedAmount: drinks[index].selectedAmount,
                    calculatedPrice: drinks[index].calculatedPrice,
                    name: drinks[index].name,
                    //check & uncheck meal
                    onCheckBoxChanged: (value) => setState(
                      () => drinks[index].isChecked = !drinks[index].isChecked,
                    ),
                    //change meal amount
                    onSliderChanged: (value) =>
                        singleWeddingVenueCubit.calculateIndividualDrinksPrice(
                      drinks[index],
                      value,
                    ),
                  )
                : EmptyCard(
                    text: 'No drinks available for ${venue.name}',
                  );
          },
        ),
      ],
    );
  }

  Widget venueText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
