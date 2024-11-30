import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
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
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_states.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeddingVenuesDetailsPage extends StatefulWidget {
  final WeddingVenue weddingVenue;

  //request the pics for null safety
  final List<CachedNetworkImage> picsList;

  const WeddingVenuesDetailsPage({
    super.key,
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

  //venue meals cubit & list
  late final WeddingVenueMealsCubit weddingVenueMealsCubit;
  late List<WeddingVenueMeal> meals = [];

  //venue meals cubit & list
  late final WeddingVenueDrinksCubit weddingVenueDrinksCubit;
  late List<WeddingVenueDrink> drinks = [];

  //venue location
  late final LocationCubit locationCubit;
  late final MapLocation venueLocation;

  //date
  late DateTime selectedDate;

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

    //get location cubit
    locationCubit = context.read<LocationCubit>();

    //get venue meals cubit
    weddingVenueMealsCubit = context.read<WeddingVenueMealsCubit>();

    //get venue drinks cubit
    weddingVenueDrinksCubit = context.read<WeddingVenueDrinksCubit>();

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

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get meals list
        meals = await weddingVenueMealsCubit.getAllMeals(weddingVenue.id);

        //get drinks list
        drinks = await weddingVenueDrinksCubit.getAllDrinks(weddingVenue.id);

        //initialize meals & drinks price
        for (int i = 0; i < meals.length; i++) {
          meals[i].calculatedPrice = meals[i].price;
        }

        for (int i = 0; i < drinks.length; i++) {
          drinks[i].calculatedPrice = drinks[i].price;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // locationCubit.close();
    scrollController.dispose();
  }

  //calculates & updates prices for drinks
  void calculateIndividualDrinksPrice(int index, double value) {
    return setState(() {
      //reset calculatedPrice value
      drinks[index].calculatedPrice = drinks[index].price;

      //update value in slider
      drinks[index].selectedAmount = value.toInt();

      //calculate price
      drinks[index].calculatedPrice =
          (drinks[index].price * value.toInt()).toPrecision(2);
    });
  }

  //calculates & updates prices for meals
  void calculateIndividualMealsPrice(int index, double value) {
    return setState(
      () {
        //reset calculatedPrice value
        meals[index].calculatedPrice = meals[index].price;

        //update value in slider
        meals[index].selectedAmount = value.toInt();

        //calculate price
        meals[index].calculatedPrice =
            (meals[index].price * value.toInt()).toPrecision(2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* title
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: FittedBox(
          child: Text(
            'Wedding Venue in Jordan',
            style: TextStyle(
              color: GColors.black,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(
              CustomIcons.menu,
              color: GColors.black,
              size: 20,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: GColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: MediaQuery.of(context).size.width > 333
          ? Center(
              //note: limited width
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                //scroll bar
                child: RawScrollbar(
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
                        weddingVenue: weddingVenue,
                        locationCubit: locationCubit,
                        venueLocation: venueLocation,
                      ),

                      const SizedBox(height: 20),

                      //* date
                      venueText('Select the date you want to book'),
                      VenueDatePicker(
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
                        //save date
                        onDateSelected: (date) =>
                            setState(() => selectedDate = date),
                      ),

                      const SizedBox(height: 20),

                      //* time
                      venueText('Select the time for your venue'),
                      VenueTimePicker(
                        text: selectedTimeText,
                        padding: padding,
                        backgroundColor: GColors.whiteShade3,
                        buttonColor: GColors.white,
                        timeColor: GColors.royalBlue,
                        initTime: selectedTime,
                        minTime: DateTime(0, 0, 0, weddingVenue.time[0]),
                        maxTime: DateTime(0, 0, 0, weddingVenue.time[1]),
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

                      //* number of expected people
                      venueText(
                          'Select the number of expected people for your venue'),
                      VenuePeopleSlider(
                        padding: padding,
                        max: weddingVenue.peopleMax,
                        min: weddingVenue.peopleMin,
                        numberOfExpectedPeople: numberOfExpectedPeople,
                        numberOfExpectedPeopleText:
                            numberOfExpectedPeople.toString(),
                        pricePerPerson: weddingVenue.peoplePrice,
                        onChanged: (value) => setState(
                            () => numberOfExpectedPeople = value.toInt()),
                      ),

                      const SizedBox(height: 20),

                      //* meals
                      venueText('Select your preferred meals'),
                      BlocConsumer<WeddingVenueMealsCubit,
                          WeddingVenueMealsStates>(
                        builder: (context, state) {
                          //error
                          if (state is WeddingVenueMealsError) {
                            return const Text('Error getting meals');
                          }

                          //done
                          if (state is WeddingVenueMealsLoaded) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: meals.isNotEmpty ? meals.length : 1,
                              //add gap between children
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              //build meals
                              itemBuilder: (context, index) {
                                return meals.isNotEmpty
                                    ? MealCard(
                                        isChecked: meals[index].isChecked,
                                        amount: meals[index].amount,
                                        price: meals[index].price,
                                        selectedAmount:
                                            meals[index].selectedAmount,
                                        name: meals[index].name,
                                        calculatedPrice:
                                            meals[index].calculatedPrice,
                                        //check & uncheck meal
                                        onCheckBoxChanged: (value) => setState(
                                            () => meals[index].isChecked =
                                                !meals[index].isChecked),
                                        //change meal amount
                                        onSliderChanged: (value) =>
                                            calculateIndividualMealsPrice(
                                                index, value),
                                      )
                                    : EmptyCard(
                                        text:
                                            'No meals available for ${weddingVenue.name}',
                                      );
                              },
                            );
                          }
                          //loading...
                          else {
                            return const GlobalLoadingBar(withImage: false);
                          }
                        },
                        listener: (context, state) {
                          //error
                          if (state is WeddingVenueMealsError) {
                            GSnackBar.show(
                                context: context, text: state.message);
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      //* drinks
                      venueText('Select your preferred drinks'),
                      BlocConsumer<WeddingVenueDrinksCubit,
                          WeddingVenueDrinksStates>(
                        builder: (context, state) {
                          //error
                          if (state is WeddingVenueDrinksError) {
                            return const Text('Error getting drinks');
                          }

                          //done
                          if (state is WeddingVenueDrinksLoaded) {
                            return ListView.separated(
                              //note: this is how to put listview inside a column
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: drinks.isNotEmpty ? drinks.length : 1,
                              //add gap between children
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              //build meals
                              itemBuilder: (context, index) {
                                return drinks.isNotEmpty
                                    ? DrinkCard(
                                        isChecked: drinks[index].isChecked,
                                        amount: drinks[index].amount,
                                        price: drinks[index].price,
                                        selectedAmount:
                                            drinks[index].selectedAmount,
                                        calculatedPrice:
                                            drinks[index].calculatedPrice,
                                        name: drinks[index].name,
                                        //check & uncheck meal
                                        onCheckBoxChanged: (value) => setState(
                                            () => drinks[index].isChecked =
                                                !drinks[index].isChecked),
                                        //change meal amount
                                        onSliderChanged: (value) =>
                                            calculateIndividualDrinksPrice(
                                                index, value),
                                      )
                                    : EmptyCard(
                                        text:
                                            'No drinks available for ${weddingVenue.name}',
                                      );
                              },
                            );
                          }
                          //loading...
                          else {
                            return const GlobalLoadingBar(withImage: false);
                          }
                        },
                        listener: (context, state) {
                          //error
                          if (state is WeddingVenueDrinksError) {
                            GSnackBar.show(
                                context: context, text: state.message);
                          }
                        },
                      ),
                      //payment

                      //back and checkout
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(),
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
