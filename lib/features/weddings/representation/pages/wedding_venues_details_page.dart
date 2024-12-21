import 'package:events_jo/config/packages/lazy%20indexed%20stack/lazy_indexed_stack.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_details_summary.dart';
import 'package:events_jo/features/weddings/representation/components/drink_card.dart';
import 'package:events_jo/features/weddings/representation/components/empty_card.dart';
import 'package:events_jo/features/weddings/representation/components/meal_card.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_image_slider.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_name_rating_and_location.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_date_picker.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_people_slider.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_time_picker.dart';
import 'package:events_jo/features/weddings/representation/components/venue_bar.dart';
import 'package:events_jo/features/weddings/representation/components/venue_changed.dart';
import 'package:events_jo/features/weddings/representation/components/venues_app_bar.dart';
import 'package:events_jo/features/weddings/representation/cubits/single%20venue/single_wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/single%20venue/single_wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  //venue location
  late final LocationCubit locationCubit;
  late final EjLocation venueLocation;

  //date
  late DateTime selectedDate;

  //time
  late DateTime selectedStartTime;
  late DateTime selectedStartTimeInit;
  late DateTime selectedEndTime;
  late DateTime selectedEndTimeInit;

  late int numberOfExpectedPeople;

  int index = 0;

  String selectedPaymentMethod = 'Credit Card';

  @override
  void initState() {
    super.initState();

    //get venue
    weddingVenue = widget.weddingVenue;

    //get cubits
    singleWeddingVenueCubit = context.read<SingleWeddingVenueCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup time
    selectedStartTime = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedStartTimeInit = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedEndTime = DateTime(0, 0, 0, weddingVenue.time[0]);
    selectedEndTimeInit = DateTime(0, 0, 0, weddingVenue.time[0]);

    //setup date
    selectedDate = DateTime(
      weddingVenue.startDate[0],
      weddingVenue.startDate[1],
      weddingVenue.startDate[2],
    );

    //setup people range
    numberOfExpectedPeople = weddingVenue.peopleMin;

    //get venue location
    venueLocation = EjLocation(
      lat: weddingVenue.latitude,
      long: weddingVenue.longitude,
      initLat: weddingVenue.latitude,
      initLong: weddingVenue.longitude,
    );

    //listen to venue
    singleWeddingVenueCubit.getSingleVenueStream(weddingVenue.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* title
      appBar: VenuesAppBar(user: widget.user),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child:
              BlocConsumer<SingleWeddingVenueCubit, SingleWeddingVenueStates>(
            listener: (context, state) {
              //change occurred
              if (state is SingleWeddingVenueChanged) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const VenueChanged(),
                  ),
                );
              }
            },
            builder: (context, state) {
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

                return LazyIndexedStack(
                  index: index,
                  children: [
                    //* details list
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        //* images slider
                        VenueImageSlider(
                          picsList: singleWeddingVenueCubit.stringsToImages(
                            venue.pics,
                          ),
                        ),

                        //* name,rating and location
                        VenueNameRatingAndLocation(
                          weddingVenue: venue,
                          locationCubit: locationCubit,
                          venueLocation: venueLocation,
                        ),

                        const SizedBox(height: 20),

                        venueText('Select the date you want to book'),

                        //* date
                        VenueDatePicker(
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
                        ),

                        const SizedBox(height: 20),

                        venueText('Select the time for your venue'),

                        //* time
                        VenueTimePicker(
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
                          confirmPressed: () => setState(() {
                            selectedStartTime = selectedStartTimeInit;
                            Navigator.of(context).pop();
                          }),
                          //do nothing
                          cancelPressed: () => Navigator.of(context).pop(),
                        ),

                        const SizedBox(height: 20),

                        //* time
                        VenueTimePicker(
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
                          confirmPressed: () => setState(() {
                            selectedEndTime = selectedEndTimeInit;
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
                          max: venue.peopleMax,
                          min: venue.peopleMin,
                          numberOfExpectedPeople: numberOfExpectedPeople,
                          pricePerPerson: venue.peoplePrice,
                          onChanged: (value) => setState(
                            () => numberOfExpectedPeople = value.toInt(),
                          ),
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
                                    calculatedPrice:
                                        meals[index].calculatedPrice,
                                    //check & uncheck meal
                                    onCheckBoxChanged: (value) => setState(
                                      () => meals[index].isChecked =
                                          !meals[index].isChecked,
                                    ),
                                    //change meal amount
                                    onSliderChanged: (value) =>
                                        singleWeddingVenueCubit
                                            .calculateIndividualMealsPrice(
                                      meals[index],
                                      value,
                                    ),
                                  )
                                : EmptyCard(
                                    text:
                                        'No meals available for ${venue.name}',
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
                                    selectedAmount:
                                        drinks[index].selectedAmount,
                                    calculatedPrice:
                                        drinks[index].calculatedPrice,
                                    name: drinks[index].name,
                                    //check & uncheck meal
                                    onCheckBoxChanged: (value) => setState(
                                      () => drinks[index].isChecked =
                                          !drinks[index].isChecked,
                                    ),
                                    //change meal amount
                                    onSliderChanged: (value) =>
                                        singleWeddingVenueCubit
                                            .calculateIndividualDrinksPrice(
                                      drinks[index],
                                      value,
                                    ),
                                  )
                                : EmptyCard(
                                    text:
                                        'No drinks available for ${venue.name}',
                                  );
                          },
                        ),

                        const SizedBox(height: 20),

                        //* payment
                        VenueBar(
                          onPressedNext: () => setState(() => index = 1),
                          onPressedBack: () => setState(
                            () => Navigator.of(context).pop(),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                    //* checkout ,total price
                    VenueDetailsSummary(
                      venue: venue,
                      selectedDate: selectedDate,
                      selectedStartTime: selectedStartTime,
                      selectedEndTime: selectedEndTime,
                      selectedMeals: selectedMeals,
                      selectedDrinks: selectedDrinks,
                      selectedPaymentMethod: selectedPaymentMethod,
                      total: () {
                        double total = 0;
                        //calculate total meals
                        for (int i = 0; i < selectedMeals.length; i++) {
                          total += selectedMeals[i].calculatedPrice;
                        }
                        //calculate total drinks
                        for (int i = 0; i < selectedDrinks.length; i++) {
                          total += selectedDrinks[i].calculatedPrice;
                        }
                        //calculate total price for people
                        total += (numberOfExpectedPeople * venue.peoplePrice);

                        return total;
                      },
                      onPressedNext: () => setState(() => index = 1),
                      onPressedBack: () => setState(() => index = 0),
                      onChanged: (value) => setState(
                          () => selectedPaymentMethod = value.toString()),
                    ),
                  ],
                );
              } else {
                return const GlobalLoadingBar(mainText: false);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget venueText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          color: GColors.royalBlue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
