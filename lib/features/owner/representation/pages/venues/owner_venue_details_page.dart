import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/packages/from%20to%20picker/from_to_picker.dart';
import 'package:events_jo/config/packages/image%20slideshow/image_slideshow.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/owner/representation/components/creation/food_card.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_venue_update_dialog.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OwnerApprovedVenueDetailsPage extends StatefulWidget {
  final WeddingVenueDetailed weddingVenueDetailed;

  const OwnerApprovedVenueDetailsPage({
    super.key,
    required this.weddingVenueDetailed,
  });

  @override
  State<OwnerApprovedVenueDetailsPage> createState() =>
      _OwnerApprovedVenueDetailsPageState();
}

class _OwnerApprovedVenueDetailsPageState
    extends State<OwnerApprovedVenueDetailsPage> {
  late final WeddingVenueDetailed venueDetailed;
  late final OwnerVenuesCubit ownerVenuesCubit;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController peoplePriceController = TextEditingController();
  final TextEditingController peopleMinController = TextEditingController();
  final TextEditingController peopleMaxController = TextEditingController();
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealAmountController = TextEditingController();
  final TextEditingController mealPriceController = TextEditingController();
  final TextEditingController drinkNameController = TextEditingController();
  final TextEditingController drinkAmountController = TextEditingController();
  final TextEditingController drinkPriceController = TextEditingController();

  List<int> updatedTime = [0, 0];
  List<int>? updatedStartTimeRange;
  List<int>? updatedEndTimeRange;
  List<dynamic>? updatedImages = [];
  List<WeddingVenueMeal>? updatedMeals = [];
  List<WeddingVenueDrink>? updatedDrinks = [];

  @override
  void initState() {
    super.initState();

    ownerVenuesCubit = context.read<OwnerVenuesCubit>();
    venueDetailed = widget.weddingVenueDetailed;
    nameController.text = venueDetailed.venue.name;
    peoplePriceController.text = venueDetailed.venue.peoplePrice.toString();
    peopleMaxController.text = venueDetailed.venue.peopleMax.toString();
    peopleMinController.text = venueDetailed.venue.peopleMin.toString();
    for (int i = 0; i < venueDetailed.venue.pics.length; i++) {
      updatedImages?.add([venueDetailed.venue.pics[i], 0]);
    }
    updatedTime[0] = venueDetailed.venue.time[0];
    updatedTime[1] = venueDetailed.venue.time[1];

    updatedMeals = List.from(venueDetailed.meals);
    updatedDrinks = List.from(venueDetailed.drinks);
  }

  @override
  void dispose() {
    nameController.dispose();
    peoplePriceController.dispose();
    peopleMinController.dispose();
    peopleMaxController.dispose();
    mealNameController.dispose();
    mealAmountController.dispose();
    mealPriceController.dispose();
    drinkNameController.dispose();
    drinkAmountController.dispose();
    drinkPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Venue Details',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                Text(
                  'Update ${venueDetailed.venue.name} Informaiton',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kNormalFontSize - 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.height,
                //name
                SettingsCard(
                  text: 'Name',
                  icon: Icons.edit,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      onCancelPressed: () {
                        if (nameController.text.trim().isEmpty) {
                          return;
                        }
                        nameController.text = venueDetailed.venue.name;
                        context.pop();
                      },
                      onDonePressed: () {
                        if (nameController.text.trim().isEmpty) {
                          return;
                        }
                        context.pop();
                      },
                      title: 'Update venue name',
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'New venue name',
                        ),
                      ),
                    ),
                  ),
                ),
                10.height,
                //images
                SettingsCard(
                  text: 'Image',
                  icon: Icons.image_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) =>
                        StatefulBuilder(builder: (context, setState) {
                      return OwnerVenueUpdateDialog(
                        title: 'Update Venue Images',
                        onDonePressed: () => context.pop(),
                        onCancelPressed: () {
                          updatedImages?.clear();
                          for (int i = 0;
                              i < venueDetailed.venue.pics.length;
                              i++) {
                            updatedImages
                                ?.add([venueDetailed.venue.pics[i], 0]);
                          }

                          context.pop();
                        },
                        actions: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.whiteShade3),
                            ),
                            onPressed: () async {
                              final List<XFile>? images =
                                  await ImagePicker().pickMultiImage(limit: 6);
                              if (images == null) {
                                return;
                              }
                              if (images.isEmpty) {
                                return;
                              }
                              for (int i = 0; i < images.length; i++) {
                                updatedImages!.add([images[i].path, 0]);
                              }

                              setState(() {});
                            },
                            icon: Text(
                              'Pick New Images',
                              style: TextStyle(
                                color: GColors.royalBlue,
                                fontSize: kSmallFontSize,
                              ),
                            ),
                          ),
                        ],
                        child: ImageSlideshow(
                          width: 300,
                          height: 300,
                          children: List.generate(
                            updatedImages?.length ?? 1,
                            (index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kOuterRadius),
                                    child: index <
                                            venueDetailed.venue.pics.length
                                        ? CachedNetworkImage(
                                            imageUrl: updatedImages![index][0],
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                const GlobalLoadingImage(),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error_outline,
                                              color: GColors.black,
                                              size: 40,
                                            ),
                                          )
                                        //todo will fail on web
                                        : Image.file(
                                            File(updatedImages![index][0])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        tooltip: updatedImages![index][1] == 0
                                            ? 'Remove'
                                            : 'Add',
                                        onPressed: () => setState(() {
                                          if (updatedImages![index][1] == 0) {
                                            updatedImages![index][1] = 1;
                                          } else {
                                            updatedImages![index][1] = 0;
                                          }
                                        }),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  GColors.whiteShade3.shade600),
                                        ),
                                        icon: Icon(
                                          index <
                                                  venueDetailed
                                                      .venue.pics.length
                                              ? updatedImages![index][1] == 0
                                                  ? Icons.link
                                                  : Icons.link_off_outlined
                                              : updatedImages![index][1] == 0
                                                  ? Icons.folder_rounded
                                                  : Icons.folder_off_rounded,
                                          size: kSmallIconSize,
                                          color: GColors.royalBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                10.height,
                //opening hours
                SettingsCard(
                  text: 'Opening Hours',
                  icon: Icons.timelapse_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      title:
                          'Update venue hours   ${updatedTime[0].toString().toTime} - ${updatedTime[1].toString().toTime}',
                      hideActions: true,
                      child: Transform.scale(
                        scale: 1.3,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: FromToTimePicker(
                            onTab: (from, to) {
                              if (from.isAfter(to)) {
                                return;
                              }
                              updatedTime[0] = from.hour;
                              updatedTime[1] = to.hour;
                              context.pop();
                            },
                            onCancelTab: () {
                              updatedTime[0] = venueDetailed.venue.time[0];
                              updatedTime[1] = venueDetailed.venue.time[1];
                              context.pop();
                            },
                            doneText: 'Done',
                            dialogBackgroundColor:
                                GColors.poloBlue.withValues(alpha: 0),
                            fromHeadlineColor: GColors.black,
                            toHeadlineColor: GColors.black,
                            timeBoxColor: GColors.royalBlue,
                            upIconColor: GColors.white,
                            downIconColor: GColors.white,
                            dividerColor: GColors.poloBlue,
                            timeTextColor: GColors.white,
                            activeDayNightColor: GColors.royalBlue,
                            dismissTextColor: GColors.redShade3,
                            defaultDayNightColor: GColors.whiteShade3,
                            doneTextColor: GColors.royalBlue,
                            dismissText: '',
                            showHeaderBullet: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.height,
                //available date
                SettingsCard(
                  text: 'Available Date',
                  icon: Icons.calendar_month_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      title: 'Update venue date',
                      onDonePressed: () => context.pop(),
                      onCancelPressed: () {
                        updatedStartTimeRange = null;
                        updatedEndTimeRange = null;
                        context.pop();
                      },
                      child: SizedBox(
                        width: kListViewWidth,
                        height: 400,
                        child: RangeDatePicker(
                          centerLeadingDate: true,
                          //min date is todays date
                          minDate: DateTime.now(),
                          //max date is a year form now
                          maxDate:
                              DateTime.now().add(const Duration(days: 365)),
                          //range select
                          onRangeSelected: (value) {
                            updatedStartTimeRange = [
                              value.start.year,
                              value.start.month,
                              value.start.day,
                            ];
                            updatedEndTimeRange = [
                              value.end.year,
                              value.end.month,
                              value.end.day,
                            ];
                          },
                          selectedRange: updatedStartTimeRange == null
                              ? null
                              : DateTimeRange(
                                  start: DateTime(
                                    updatedStartTimeRange![0],
                                    updatedStartTimeRange![1],
                                    updatedStartTimeRange![2],
                                  ),
                                  end: DateTime(
                                    updatedEndTimeRange![0],
                                    updatedEndTimeRange![1],
                                    updatedEndTimeRange![2],
                                  ),
                                ),
                          currentDate: updatedStartTimeRange == null
                              ? DateTime.now()
                              : DateTime(
                                  updatedStartTimeRange![0],
                                  updatedStartTimeRange![1],
                                  updatedStartTimeRange![2],
                                ),
                          //styling down
                          disabledCellsTextStyle: TextStyle(
                            color:
                                GColors.black.shade300.withValues(alpha: 0.5),
                            fontSize: kSmallFontSize,
                            fontFamily: 'Abel',
                          ),
                          selectedCellsDecoration: BoxDecoration(
                            color: GColors.whiteShade3.shade600,
                          ),
                          splashRadius: 15,
                          currentDateDecoration: BoxDecoration(
                            border: Border.all(
                              color: GColors.royalBlue,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          enabledCellsTextStyle: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontFamily: 'Abel',
                          ),
                          currentDateTextStyle: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontFamily: 'Abel',
                          ),
                          selectedCellsTextStyle: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: kSmallFontSize,
                            fontFamily: 'Abel',
                          ),
                          slidersColor: GColors.black,
                          singleSelectedCellTextStyle: TextStyle(
                            color: GColors.white,
                            fontSize: kSmallFontSize,
                            fontFamily: 'Abel',
                          ),
                          singleSelectedCellDecoration: BoxDecoration(
                            color: GColors.royalBlue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          daysOfTheWeekTextStyle: TextStyle(
                              color: GColors.black.withValues(alpha: 0.7),
                              fontSize: kSmallFontSize - 2,
                              fontFamily: 'Abel'),
                          leadingDateTextStyle: TextStyle(
                            color: GColors.black,
                            fontSize: kNormalFontSize,
                            fontFamily: 'Abel',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.height,
                //amount of people
                SettingsCard(
                  text: 'Amount of People',
                  icon: Icons.person_pin_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      title: 'Update venue capacity',
                      onDonePressed: () {
                        if (peopleMinController.text.trim().isEmpty) {
                          return;
                        }
                        if (peopleMaxController.text.trim().isEmpty) {
                          return;
                        }
                        if (int.parse(peopleMinController.text) >=
                            int.parse(peopleMaxController.text)) {
                          return;
                        }

                        context.pop();
                      },
                      onCancelPressed: () {
                        peopleMaxController.text =
                            venueDetailed.venue.peopleMax.toString();
                        peopleMinController.text =
                            venueDetailed.venue.peopleMin.toString();
                        context.pop();
                      },
                      child: Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: peopleMinController,
                              decoration: const InputDecoration(
                                hintText: 'Minimum Amount',
                              ),
                              maxLength: 7,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: peopleMaxController,
                              decoration: const InputDecoration(
                                hintText: 'Maximum Amount',
                              ),
                              maxLength: 7,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.height,
                //price per person
                SettingsCard(
                  text: 'Price per Person',
                  icon: Icons.price_change_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      title: 'Update venue price',
                      onDonePressed: () {
                        if (peoplePriceController.text.trim().isEmpty) {
                          return;
                        }
                        context.pop();
                      },
                      onCancelPressed: () {
                        peoplePriceController.text =
                            venueDetailed.venue.peoplePrice.toString();
                        context.pop();
                      },
                      child: TextField(
                        controller: peoplePriceController,
                        decoration: const InputDecoration(
                          hintText: 'Price per person',
                        ),
                        maxLength: 7,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.height,
                //meals
                SettingsCard(
                  text: 'Meals',
                  icon: Icons.soup_kitchen_rounded,
                  onTap: () => context.dialog(
                    pageBuilder: (p0, p1, p2) =>
                        StatefulBuilder(builder: (context, setState) {
                      return OwnerVenueUpdateDialog(
                        onDonePressed: () => context.pop(),
                        onCancelPressed: () {
                          updatedMeals = venueDetailed.meals;
                          context.pop();
                        },
                        actions: [
                          IconButton(
                            onPressed: () => setState(
                              () {
                                //checks if fields are empty
                                if (mealNameController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add a name for the meal');
                                  return;
                                }
                                if (mealAmountController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add an amount for the meal');
                                  return;
                                }
                                if (mealPriceController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add a price for the meal');
                                  return;
                                }

                                //add meal to list
                                updatedMeals?.add(
                                  WeddingVenueMeal(
                                    id: 'added later :D',
                                    name: mealNameController.text.trim(),
                                    amount:
                                        int.parse(mealAmountController.text),
                                    price:
                                        double.parse(mealPriceController.text),
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
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                GColors.whiteShade3,
                              ),
                            ),
                            icon: Text(
                              'Add Meal',
                              style: TextStyle(
                                color: GColors.royalBlue,
                                fontSize: kSmallIconSize,
                              ),
                            ),
                          ),
                        ],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FoodCard(
                                    imageUrl: ImageForString.get(
                                      mealNameController.text,
                                      FoodType.meal,
                                    ),
                                    padding: EdgeInsets.zero,
                                    width: 55,
                                    height: 55,
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      controller: mealNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Meal Name',
                                        counter: 0.width,
                                      ),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {}),
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  icon: Icon(
                                    Icons.menu_open_rounded,
                                    color: GColors.white,
                                    size: kNormalIconSize,
                                  ),
                                  style: ButtonStyle(
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(12)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        GColors.royalBlue),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(kOuterRadius),
                                      ),
                                    ),
                                  ),
                                  color: GColors.white,
                                  constraints:
                                      const BoxConstraints(maxHeight: 200),
                                  onSelected: (value) => setState(() =>
                                      mealNameController.text =
                                          value.toString()),
                                  tooltip: '',
                                  enableFeedback: false,
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (context) {
                                    final mealsList = ImageForString
                                        .stringToImageMealsMap.keys
                                        .toList();
                                    return List.generate(
                                      mealsList.length,
                                      (index) {
                                        return PopupMenuItem(
                                          value: mealsList[index]
                                              .toString()
                                              .toTitleCase,
                                          child: Text(
                                            mealsList[index]
                                                .toString()
                                                .toTitleCase,
                                            style: TextStyle(
                                              color: GColors.royalBlue,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10,
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: mealAmountController,
                                    maxLength: 7,
                                    decoration: const InputDecoration(
                                      hintText: 'Meal Amount',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: mealPriceController,
                                    decoration: const InputDecoration(
                                      hintText: 'Meal Price',
                                    ),
                                    maxLength: 7,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: updatedMeals?.length ?? 0,
                                separatorBuilder: (context, index) => 5.height,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: GColors.white,
                                    borderRadius:
                                        BorderRadius.circular(kOuterRadius),
                                  ),
                                  child: Row(
                                    spacing: 5,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${index + 1}- ${updatedMeals?[index].name}',
                                              style: TextStyle(
                                                color: GColors.black,
                                                fontSize: kSmallFontSize,
                                              ),
                                            ),
                                            Text(
                                              'Amount: ' +
                                                  updatedMeals![index]
                                                      .amount
                                                      .toString(),
                                              style: TextStyle(
                                                color: GColors.black,
                                                fontSize: kSmallFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => setState(() =>
                                            updatedMeals?.removeAt(index)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            GColors.redShade3
                                                .withValues(alpha: 0.3),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.clear_sharp,
                                          size: kSmallIconSize,
                                          color: GColors.redShade3.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                10.height,
                //drinks
                SettingsCard(
                  text: 'Drinks',
                  icon: Icons.local_drink_rounded,
                  onTap: () => context.dialog(
                    pageBuilder: (p0, p1, p2) =>
                        StatefulBuilder(builder: (context, setState) {
                      return OwnerVenueUpdateDialog(
                        onDonePressed: () => context.pop(),
                        onCancelPressed: () {
                          updatedDrinks = venueDetailed.drinks;
                          context.pop();
                        },
                        actions: [
                          IconButton(
                            onPressed: () => setState(
                              () {
                                //checks if fields are empty
                                if (drinkNameController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add a name for the drink');
                                  return;
                                }
                                if (drinkAmountController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add an amount for the drink');
                                  return;
                                }
                                if (drinkPriceController.text.isEmpty) {
                                  context.showSnackBar(
                                      'Please add a price for the drink');
                                  return;
                                }

                                //add drink to list
                                updatedDrinks?.add(
                                  WeddingVenueDrink(
                                    id: 'added later :D',
                                    name: drinkNameController.text.trim(),
                                    amount:
                                        int.parse(drinkAmountController.text),
                                    price:
                                        double.parse(drinkPriceController.text),
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
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                GColors.whiteShade3,
                              ),
                            ),
                            icon: Text(
                              'Add Drink',
                              style: TextStyle(
                                color: GColors.royalBlue,
                                fontSize: kSmallIconSize,
                              ),
                            ),
                          ),
                        ],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FoodCard(
                                    imageUrl: ImageForString.get(
                                      drinkNameController.text,
                                      FoodType.drink,
                                    ),
                                    padding: EdgeInsets.zero,
                                    width: 55,
                                    height: 55,
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      controller: drinkNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Drink Name',
                                        counter: 0.width,
                                      ),
                                      maxLength: 25,
                                      onChanged: (value) => setState(() {}),
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  icon: Icon(
                                    Icons.menu_open_rounded,
                                    color: GColors.white,
                                    size: kNormalIconSize,
                                  ),
                                  style: ButtonStyle(
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(12)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        GColors.royalBlue),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(kOuterRadius),
                                      ),
                                    ),
                                  ),
                                  color: GColors.white,
                                  constraints:
                                      const BoxConstraints(maxHeight: 200),
                                  onSelected: (value) => setState(() =>
                                      drinkNameController.text =
                                          value.toString()),
                                  tooltip: '',
                                  enableFeedback: false,
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (context) {
                                    final drinksList = ImageForString
                                        .stringToImageDrinksMap.keys
                                        .toList();
                                    return List.generate(
                                      drinksList.length,
                                      (index) {
                                        return PopupMenuItem(
                                          value: drinksList[index]
                                              .toString()
                                              .toTitleCase,
                                          child: Text(
                                            drinksList[index]
                                                .toString()
                                                .toTitleCase,
                                            style: TextStyle(
                                              color: GColors.royalBlue,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10,
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: drinkAmountController,
                                    maxLength: 7,
                                    decoration: const InputDecoration(
                                      hintText: 'Drink Amount',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: drinkPriceController,
                                    decoration: const InputDecoration(
                                      hintText: 'Drink Price',
                                    ),
                                    maxLength: 7,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: updatedDrinks?.length ?? 0,
                                separatorBuilder: (context, index) => 5.height,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: GColors.white,
                                    borderRadius:
                                        BorderRadius.circular(kOuterRadius),
                                  ),
                                  child: Row(
                                    spacing: 5,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${index + 1}- ${updatedDrinks?[index].name}',
                                              style: TextStyle(
                                                color: GColors.black,
                                                fontSize: kSmallFontSize,
                                              ),
                                            ),
                                            Text(
                                              'Amount: ' +
                                                  updatedDrinks![index]
                                                      .amount
                                                      .toString(),
                                              style: TextStyle(
                                                color: GColors.black,
                                                fontSize: kSmallFontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => setState(() =>
                                            updatedDrinks?.removeAt(index)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            GColors.redShade3
                                                .withValues(alpha: 0.3),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.clear_sharp,
                                          size: kSmallIconSize,
                                          color: GColors.redShade3.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: GColors.whiteShade3.shade600,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kOuterRadius),
            topRight: Radius.circular(kOuterRadius),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: IconButton(
          onPressed: () async {
            context.pop();
            await ownerVenuesCubit.updateVenue(
              WeddingVenueDetailed(
                venue: WeddingVenue(
                  //won't update
                  id: venueDetailed.venue.id,
                  latitude: venueDetailed.venue.latitude,
                  longitude: venueDetailed.venue.longitude,
                  rates: venueDetailed.venue.rates,
                  isOpen: venueDetailed.venue.isOpen,
                  isApproved: venueDetailed.venue.isApproved,
                  isBeingApproved: venueDetailed.venue.isBeingApproved,
                  ownerId: venueDetailed.venue.ownerId,
                  ownerName: venueDetailed.venue.ownerName,
                  city: venueDetailed.venue.city,
                  //will update
                  name: nameController.text,
                  pics: venueDetailed.venue.pics,
                  time: updatedTime,
                  startDate:
                      updatedStartTimeRange ?? venueDetailed.venue.startDate,
                  endDate: updatedEndTimeRange ?? venueDetailed.venue.endDate,
                  peopleMax: int.parse(peopleMaxController.text),
                  peopleMin: int.parse(peopleMinController.text),
                  peoplePrice: double.parse(peoplePriceController.text),
                ),
                meals: updatedMeals ?? venueDetailed.meals,
                drinks: updatedDrinks ?? venueDetailed.drinks,
              ),
              updatedImages ?? [],
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
          ),
          icon: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: kNormalIconSize,
                color: GColors.white,
              ),
              Text(
                'Update Venue',
                style: TextStyle(
                  color: GColors.white,
                  fontSize: kNormalFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
