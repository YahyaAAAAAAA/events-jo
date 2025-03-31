import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/packages/from%20to%20picker/from_to_picker.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_venue_update_dialog.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<int> updatedTime = [0, 0];
  List<int>? updatedStartTimeRange;
  List<int>? updatedEndTimeRange;

  @override
  void initState() {
    super.initState();

    ownerVenuesCubit = context.read<OwnerVenuesCubit>();
    venueDetailed = widget.weddingVenueDetailed;
    nameController.text = venueDetailed.venue.name;
    peoplePriceController.text = venueDetailed.venue.peoplePrice.toString();
    peopleMaxController.text = venueDetailed.venue.peopleMax.toString();
    peopleMinController.text = venueDetailed.venue.peopleMin.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    peoplePriceController.dispose();
    peopleMinController.dispose();
    peopleMaxController.dispose();
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
                const SettingsCard(text: 'Image', icon: Icons.image_rounded),
                10.height,
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
                const SettingsCard(
                    text: 'Meals', icon: Icons.soup_kitchen_rounded),
                10.height,
                const SettingsCard(
                    text: 'Drinks', icon: Icons.local_drink_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateDetailPage extends StatelessWidget {
  final String detail;
  final WeddingVenueDetailed weddingVenueDetailed;

  const UpdateDetailPage({
    super.key,
    required this.detail,
    required this.weddingVenueDetailed,
  });

  @override
  Widget build(BuildContext context) {
    // Implement the UI for updating the specific detail
    return Scaffold(
      appBar: AppBar(
        title: Text('Update $detail'),
      ),
      body: Center(
        child: Text('Update $detail page for ${weddingVenueDetailed}'),
      ),
    );
  }
}
