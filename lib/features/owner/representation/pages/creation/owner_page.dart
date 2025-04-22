import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/packages/lazy%20indexed%20stack/lazy_indexed_stack.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_app_bar.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_drink_card.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_meal_card.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/confirm_event_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/event_added_successfully_page.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_drinks_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_location_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_meals_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_name_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_type_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_images_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_license_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_people_range.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_range_date_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_range_time_page.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_states.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
//note: check if platform is web
import 'package:flutter/foundation.dart' show kIsWeb;

//* This page lets owners create an event
class OwnerPage extends StatefulWidget {
  final AppUser? user;
  const OwnerPage({
    super.key,
    required this.user,
  });

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  late final AppUser user;

  //owner cubit instance
  late final OwnerCubit ownerCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  //event name
  final TextEditingController nameController = TextEditingController();

  //current page in the stack
  int index = 0;

  //venue, farm or court
  EventType eventType = EventType.venue;

  //event date and time
  DateTimeRange? range;
  List<int> time = [12, 12];

  //temp value for UI control
  int tempValueForTime = 0;

  //images list
  List<XFile> images = [];

  //license
  List<XFile> license = [];

  //people
  TextEditingController peopleMinController = TextEditingController();
  TextEditingController peopleMaxController = TextEditingController();
  TextEditingController peoplePriceController = TextEditingController();

  //meals
  List<WeddingVenueMeal> meals = [];
  TextEditingController mealNameController = TextEditingController();
  TextEditingController mealAmountController = TextEditingController();
  TextEditingController mealPriceController = TextEditingController();

  //meals
  List<WeddingVenueDrink> drinks = [];
  TextEditingController drinkNameController = TextEditingController();
  TextEditingController drinkAmountController = TextEditingController();
  TextEditingController drinkPriceController = TextEditingController();
  @override
  void initState() {
    super.initState();

    //get user
    user = widget.user!;

    //get cubits
    ownerCubit = context.read<OwnerCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: user.latitude,
      long: user.longitude,
      initLat: user.latitude,
      initLong: user.longitude,
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mealNameController.dispose();
    mealAmountController.dispose();
    mealPriceController.dispose();
    drinkNameController.dispose();
    drinkAmountController.dispose();
    drinkPriceController.dispose();
    peopleMinController.dispose();
    peopleMaxController.dispose();
    peoplePriceController.dispose();
    ownerCubit.emit(OwnerInitial());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //disables native back button
      canPop: false,
      child: Scaffold(
        appBar: OwnerAppBar(index: index),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            //loads children only when needed
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LazyIndexedStack(
                index: index,
                children: [
                  //* owner sub pages
                  //type
                  Column(
                    spacing: 10,
                    children: [
                      SelectEventType(
                        eventType: eventType,
                        onSelected: (event) =>
                            setState(() => eventType = event),
                      ),

                      //name
                      SelectEventNamePage(
                        eventType: eventType,
                        nameController: nameController,
                      ),

                      //location
                      SelectEventLocationPage(
                        eventType: eventType,
                        onPressed: () => locationCubit.showMapDialog(
                          context,
                          userLocation: userLocation,
                        ),
                      ),

                      //pics
                      SelectImagesPage(
                        images: images,
                        eventType: eventType,
                        onPressed: () async {
                          //pick images
                          final selectedImages =
                              await ImagePicker().pickMultiImage(limit: 6);

                          //user cancels -> save old list
                          if (selectedImages.isEmpty) return;

                          //user confirms -> clear old list and add new images
                          images.clear();
                          images.addAll(selectedImages);

                          //update
                          setState(() {});
                        },
                      ),

                      //license
                      SelectLicensePage(
                        images: license,
                        eventType: eventType,
                        onPressed: () async {
                          //pick images
                          final selectedLicense =
                              await ImagePicker().pickMultiImage(limit: 2);

                          //save old license
                          if (selectedLicense.isEmpty) return;

                          //save new license
                          license.clear();
                          license.add(selectedLicense.first);

                          //update
                          setState(() {});
                        },
                      ),

                      TextButton(
                        onPressed: () async {
                          await ownerCubit.addCourtToDatabase();
                        },
                        child: const Text(
                          'data',
                        ),
                      ),
                    ],
                  ),

                  //date range
                  SelectRangeDatePage(
                    range: range,
                    onRangeSelected: (value) => setState(() => range = value),
                  ),

                  //time range
                  SelectRangeTimePage(
                    tempValueForTime: tempValueForTime,
                    time: time,
                    onTab: (from, to) => setState(
                      () {
                        //control UI
                        tempValueForTime = 1;

                        //set time
                        time[0] = from.hour;
                        time[1] = to.hour;
                      },
                    ),
                  ),

                  //people range
                  SelectPeopleRange(
                    peoplePriceController: peoplePriceController,
                    peopleMinController: peopleMinController,
                    peopleMaxController: peopleMaxController,
                  ),

                  //meals
                  SelectEventMealsPage(
                    mealNameController: mealNameController,
                    mealAmountController: mealAmountController,
                    mealPriceController: mealPriceController,
                    meals: meals,
                    //update image when typing (only update state)
                    onTextFieldChanged: (text) => setState(() {}),
                    //update field on menu select
                    onMealSelected: (meal) => setState(
                        () => mealNameController.text = meal.toString()),
                    itemBuilder: (context, index) {
                      return OwnerMealCard(
                        meals: meals,
                        index: index,
                        key: Key(ownerCubit.generateUniqueId()),
                        onPressed: () => setState(() => meals.removeAt(index)),
                      );
                    },
                    onAddPressed: () {
                      //checks if fields are empty
                      if (mealNameController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a name for the meal');
                        return;
                      }
                      if (mealAmountController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add an amount for the meal');
                        return;
                      }
                      if (mealPriceController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a price for the meal');
                        return;
                      }

                      //add meal to list
                      meals.add(
                        WeddingVenueMeal(
                          id: 'added later :D',
                          name: mealNameController.text.trim(),
                          amount: int.parse(mealAmountController.text),
                          price: double.parse(mealPriceController.text),
                        ),
                      );

                      //clear fields after addition
                      mealNameController.clear();
                      mealAmountController.clear();
                      mealPriceController.clear();

                      //update
                      setState(() {});
                    },
                  ),

                  //drinks
                  SelectEventDrinksPage(
                    drinkNameController: drinkNameController,
                    drinkAmountController: drinkAmountController,
                    drinkPriceController: drinkPriceController,
                    drinks: drinks,
                    //update image when typing (only update state)
                    onChanged: (text) => setState(() {}),
                    //update field on menu select
                    onDrinkSelected: (drink) => setState(
                        () => drinkNameController.text = drink.toString()),
                    itemBuilder: (context, index) {
                      return OwnerDrinkCard(
                        drinks: drinks,
                        index: index,
                        key: Key(ownerCubit.generateUniqueId()),
                        onPressed: () => setState(() => drinks.removeAt(index)),
                      );
                    },
                    onAddPressed: () {
                      //checks if fields are empty
                      if (drinkNameController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a name for the drink');
                        return;
                      }
                      if (drinkAmountController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add an amount for the drink');
                        return;
                      }
                      if (drinkPriceController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a price for the drink');
                        return;
                      }

                      //add meal to list
                      drinks.add(
                        WeddingVenueDrink(
                          id: 'added later :D',
                          name: drinkNameController.text.trim(),
                          amount: int.parse(drinkAmountController.text),
                          price: double.parse(drinkPriceController.text),
                        ),
                      );

                      //clear fields after addition
                      drinkNameController.clear();
                      drinkAmountController.clear();
                      drinkPriceController.clear();

                      //update
                      setState(() {});
                    },
                  ),

                  //* submit
                  submitEvent(),
                ],
              ),
            ),
          ),
        ),

        //watch the state here to hide the bar when loading
        bottomNavigationBar: BlocConsumer<OwnerCubit, OwnerStates>(
          builder: (context, state) {
            //user haven't submitted yet
            if (state is OwnerInitial) {
              return OwnerPageNavigationBar(
                index: index,
                //this method checks user input and control current page
                onPressedNext: () => setState(
                  () {
                    //if no name provided
                    if (index == 1) {
                      if (nameController.text.isEmpty) {
                        GSnackBar.show(
                            context: context, text: 'Please enter a name');
                        return;
                      }
                    }

                    if (index == 4) {
                      if (license.isEmpty) {
                        GSnackBar.show(
                            context: context, text: 'Please provide a license');
                        return;
                      }
                    }

                    //if no date range provided
                    if (index == 5) {
                      if (range == null) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please enter a range of date');
                        return;
                      }
                    }

                    //if no time range provided
                    if (index == 6) {
                      if (tempValueForTime == 0) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please enter a range of time');
                        return;
                      }
                    }

                    //if no people price or range provided
                    if (index == 7) {
                      //checks if fields are empty
                      if (peoplePriceController.text.isEmpty) {
                        GSnackBar.show(
                            context: context, text: 'Please add a price');
                        return;
                      }
                      if (peopleMinController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a minimum amount');
                        return;
                      }
                      if (peopleMaxController.text.isEmpty) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a maximum amount');
                        return;
                      }
                      //checks if valid range
                      if (int.parse(peopleMinController.text) >=
                          int.parse(peopleMaxController.text)) {
                        GSnackBar.show(
                            context: context,
                            text: 'Please add a valid range of people');
                        return;
                      }
                    }

                    //last page
                    if (index == 10) {
                      return;
                    }

                    //next page
                    index += 1;
                  },
                ),
                onPressedBack: () => setState(
                  () {
                    //if no more pages (go home)
                    if (index == 0) {
                      Navigator.of(context).pop();
                      return;
                    }

                    //previous page
                    index -= 1;
                  },
                ),
              );
            }
            //loading...
            else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            //error
            if (state is OwnerError) {
              GSnackBar.show(context: context, text: state.message);
            }
          },
        ),
      ),
    );
  }

  //last page
  BlocConsumer<OwnerCubit, OwnerStates> submitEvent() {
    return BlocConsumer<OwnerCubit, OwnerStates>(
      builder: (context, state) {
        //initial
        if (state is OwnerInitial) {
          return ConfirmEventPage(
            eventType: eventType,
            name: nameController.text,
            range: range,
            time: time,
            peopleMax: int.parse(peopleMaxController.text),
            peopleMin: int.parse(peopleMinController.text),
            peoplePrice: double.parse(peoplePriceController.text),
            showMeals: () => ownerCubit.showMealsDialogPreview(context, meals),
            showDrinks: () =>
                ownerCubit.showDrinksDialogPreview(context, drinks),
            showMap: () => locationCubit.showMapDialogPreview(context,
                userLocation: userLocation),
            showImages: () =>
                ownerCubit.showImagesDialogPreview(context, images, kIsWeb),
            showLicense: () =>
                ownerCubit.showImagesDialogPreview(context, license, kIsWeb),
            onPressed: () async {
              //reset urls for images
              List<String> urls = [];
              urls.clear();

              //if user selected images
              if (images.isNotEmpty) {
                urls = await ownerCubit.addImagesToServer(
                    images, nameController.text);
              }

              //call cubit
              await ownerCubit.addVenueToDatabase(
                name: nameController.text.trim(),
                lat: userLocation.lat,
                long: userLocation.long,
                peopleMax: int.parse(peopleMaxController.text),
                peopleMin: int.parse(peopleMinController.text),
                peoplePrice: double.parse(peoplePriceController.text),
                pics: images.isNotEmpty ? urls : null,
                meals: meals.isNotEmpty ? meals : null,
                drinks: drinks.isNotEmpty ? drinks : null,
                startDate: [
                  range!.start.year,
                  range!.start.month,
                  range!.start.day,
                ],
                endDate: [
                  range!.end.year,
                  range!.end.month,
                  range!.end.day,
                ],
                time: [
                  time[0],
                  time[1],
                ],
                ownerId: user.uid,
                ownerName: user.name,
              );
            },
          );
        }

        //done
        if (state is OwnerLoaded) {
          return EventAddedSuccessfullyPage(
            eventType: eventType,
            onPressed: () => Navigator.of(context).pop(),
          );
        }

        //error
        if (state is OwnerError) {
          return const Center(
            child: Text('There was an error'),
          );
        }

        //loading...
        else {
          return const GlobalLoadingBar(mainText: false);
        }
      },
      listener: (context, state) {
        //notify user when (image uploading) and (event uploading)
        if (state is OwnerLoading) {
          GSnackBar.show(
              context: context,
              text: state.messege,
              duration: const Duration(seconds: 1));
        }
        //error
        if (state is OwnerError) {
          GSnackBar.show(context: context, text: state.message);
        }
      },
    );
  }
}
