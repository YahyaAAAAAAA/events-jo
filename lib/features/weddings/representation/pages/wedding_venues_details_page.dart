import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/owner/representation/pages/sub%20pages/select_range_time_page.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/components/drink_card.dart';
import 'package:events_jo/features/weddings/representation/components/empty_card.dart';
import 'package:events_jo/features/weddings/representation/components/meal_card.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_image_slider.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_name_rating_and_location.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_date_picker.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_people_slider.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_time_picker.dart';
import 'package:events_jo/features/weddings/representation/components/venues_app_bar.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/single/single_wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/single/single_wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeddingVenuesDetailsPage extends StatefulWidget {
  final AppUser? user;
  final WeddingVenue weddingVenue;

  //request the pics for null safety
  final List<CachedNetworkImage> picsList;

  const WeddingVenuesDetailsPage({
    super.key,
    required this.user,
    required this.weddingVenue,
    required this.picsList,
  });

  @override
  State<WeddingVenuesDetailsPage> createState() =>
      _WeddingVenuesDetailsPageState();
}

class _WeddingVenuesDetailsPageState extends State<WeddingVenuesDetailsPage> {
  //current venue
  late final WeddingVenue weddingVenue;

  late final SingleWeddingVenueCubit singleWeddingVenueCubit;

  //venue location
  late final LocationCubit locationCubit;
  late final MapLocation venueLocation;

  //date
  late DateTime selectedDate;
  late DateTime minDate;
  late DateTime maxDate;

  //time
  late DateTime selectedTime;
  late DateTime selectedTimeInit;
  late String selectedTimeText;
  late String selectedInitTimeText;

  late int numberOfExpectedPeople;

  final ScrollController scrollController = ScrollController();

  double padding = 12;

  @override
  void initState() {
    super.initState();

    //get venue
    weddingVenue = widget.weddingVenue;

    //get cubits
    singleWeddingVenueCubit = context.read<SingleWeddingVenueCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup time
    selectedTime = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedTimeInit = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedTimeText = 'Your venue time: ' +
        weddingVenue.time[0].toString().toTimeWithMinutes('0');
    selectedInitTimeText = 'Your venue time: ' +
        weddingVenue.time[0].toString().toTimeWithMinutes('0');

    //setup date
    selectedDate = DateTime(
      weddingVenue.startDate[0],
      weddingVenue.startDate[1],
      weddingVenue.startDate[2],
    );

    minDate = DateTime(
      weddingVenue.startDate[0],
      weddingVenue.startDate[1],
      weddingVenue.startDate[2],
    );

    maxDate = DateTime(
      weddingVenue.endDate[0],
      weddingVenue.endDate[1],
      weddingVenue.endDate[2],
    );

    //setup people range
    numberOfExpectedPeople = weddingVenue.peopleMin;

    //get venue location
    venueLocation = MapLocation(
      lat: weddingVenue.latitude,
      long: weddingVenue.longitude,
      initLat: weddingVenue.latitude,
      initLong: weddingVenue.longitude,
      marker: Marker(
        point: LatLng(
          weddingVenue.latitude,
          weddingVenue.longitude,
        ),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );

    //listen to venue
    singleWeddingVenueCubit.getSingleVenueStream(weddingVenue.id);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  //calculates & updates prices for drinks
  void calculateIndividualDrinksPrice(WeddingVenueDrink drink, double value) {
    return setState(() {
      //reset calculatedPrice value
      drink.calculatedPrice = drink.price;

      //update value in slider
      drink.selectedAmount = value.toInt();

      //calculate price
      drink.calculatedPrice = (drink.price * value.toInt()).toPrecision(2);
    });
  }

  //calculates & updates prices for meals
  void calculateIndividualMealsPrice(WeddingVenueMeal meal, double value) {
    return setState(
      () {
        //reset calculatedPrice value
        meal.calculatedPrice = meal.price;

        //update value in slider
        meal.selectedAmount = value.toInt();

        //calculate price
        meal.calculatedPrice = (meal.price * value.toInt()).toPrecision(2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* title
      appBar: VenuesAppBar(user: widget.user),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          //scroll bar
          child:
              BlocConsumer<SingleWeddingVenueCubit, SingleWeddingVenueStates>(
            listener: (context, state) {
              if (state is SingleWeddingVenueChanged) {
                // Navigator.of(context).pop();
                GSnackBar.show(context: context, text: state.change);
              }
            },
            builder: (context, state) {
              if (state is SingleWeddingVenueChanged) {
                return const Text('dddddddd');
              }
              if (state is SingleWeddingVenueLoaded) {
                final venue = state.data.venue;
                final meals = state.data.meals;
                final drinks = state.data.drinks;

                return RawScrollbar(
                  thumbVisibility: true,
                  radius: const Radius.circular(12),
                  thumbColor: GColors.poloBlue.withOpacity(0.5),
                  controller: scrollController,
                  interactive: true,
                  //main list
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12),
                    children: [
                      //* images slider
                      VenueImageSlider(picsList: widget.picsList),

                      //* name,rating and location
                      VenueNameRatingAndLocation(
                        padding: padding,
                        weddingVenue: venue,
                        locationCubit: locationCubit,
                        venueLocation: venueLocation,
                      ),

                      const SizedBox(height: 20),

                      venueText('Select the date you want to book'),

                      //* date
                      VenueDatePicker(
                        minDate: minDate,
                        maxDate: maxDate,
                        //save date
                        onDateSelected: (date) =>
                            setState(() => selectedDate = date),
                      ),

                      const SizedBox(height: 20),

                      venueText('Select the time for your venue'),

                      //* time
                      VenueTimePicker(
                        text: selectedTimeText,
                        padding: padding,
                        backgroundColor: GColors.whiteShade3,
                        buttonColor: GColors.white,
                        timeColor: GColors.royalBlue,
                        initTime: selectedTime,
                        minTime: DateTime(0, 0, 0, venue.time[0]),
                        maxTime: DateTime(0, 0, 0, venue.time[1]),
                        minuteInterval: 10,
                        use24hFormat: false,
                        //waits for confirmation
                        onDateTimeChanged: (date) {
                          selectedInitTimeText = 'Your venue time: ' +
                              date.hour
                                  .toString()
                                  .toTimeWithMinutes(date.minute.toString());
                          selectedTimeInit = date;
                        },
                        //saves selected time
                        confirmPressed: () => setState(() {
                          selectedTimeText = selectedInitTimeText;
                          selectedTime = selectedTimeInit;
                          Navigator.of(context).pop();
                        }),
                        //do nothing
                        cancelPressed: () => Navigator.of(context).pop(),
                      ),

                      const SizedBox(height: 20),

                      venueText(
                          'Select the number of expected people for your venue'),

                      //* number of expected people
                      VenuePeopleSlider(
                        padding: padding,
                        max: venue.peopleMax,
                        min: venue.peopleMin,
                        numberOfExpectedPeople: numberOfExpectedPeople,
                        pricePerPerson: venue.peoplePrice,
                        onChanged: (value) => setState(
                            () => numberOfExpectedPeople = value.toInt()),
                      ),

                      const SizedBox(height: 20),

                      venueText('Select your preferred meals'),

                      //* meals
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: meals.isNotEmpty ? meals.length : 1,
                        //add gap between children
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
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
                                    () => meals[index].isChecked =
                                        !meals[index].isChecked,
                                  ),
                                  //change meal amount
                                  onSliderChanged: (value) =>
                                      calculateIndividualMealsPrice(
                                    meals[index],
                                    value,
                                  ),
                                )
                              : EmptyCard(
                                  text: 'No meals available for ${venue.name}',
                                );
                        },
                      ),

                      const SizedBox(height: 20),

                      venueText('Select your preferred drinks'),

                      //* drinks
                      ListView.separated(
                        //note: this is how to put listview inside a column
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: drinks.isNotEmpty ? drinks.length : 1,
                        //add gap between children
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        //build meals
                        itemBuilder: (context, index) {
                          return drinks.isNotEmpty
                              ? DrinkCard(
                                  isChecked: drinks[index].isChecked,
                                  amount: drinks[index].amount,
                                  price: drinks[index].price,
                                  selectedAmount: drinks[index].selectedAmount,
                                  calculatedPrice:
                                      drinks[index].calculatedPrice,
                                  name: drinks[index].name,
                                  //check & uncheck meal
                                  onCheckBoxChanged: (value) => setState(() =>
                                      drinks[index].isChecked =
                                          !drinks[index].isChecked),
                                  //change meal amount
                                  onSliderChanged: (value) =>
                                      calculateIndividualDrinksPrice(
                                          drinks[index], value),
                                )
                              : EmptyCard(
                                  text: 'No drinks available for ${venue.name}',
                                );
                        },
                      ),
                      //payment

                      //back and checkout
                    ],
                  ),
                );
              } else {
                return const GlobalLoadingBar();
              }
            },
          ),
        ),
      ),
    );
  }

  Text venueText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        color: GColors.poloBlue,
      ),
    );
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
