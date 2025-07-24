import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/packages/from%20to%20picker/from_to_picker.dart';
import 'package:events_jo/config/packages/image%20slideshow/image_slideshow.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_venue_update_dialog.dart';
import 'package:events_jo/features/owner/representation/cubits/courts/owner_courts_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OwnerApprovedCourtDetailsPage extends StatefulWidget {
  final FootballCourt footballCourt;

  const OwnerApprovedCourtDetailsPage({
    super.key,
    required this.footballCourt,
  });

  @override
  State<OwnerApprovedCourtDetailsPage> createState() =>
      _OwnerApprovedCourtDetailsPageState();
}

class _OwnerApprovedCourtDetailsPageState
    extends State<OwnerApprovedCourtDetailsPage> {
  late final FootballCourt footballCourt;
  late final OwnerCourtsCubit ownerCourtsCubit;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController peoplePriceController = TextEditingController();

  List<int> updatedTime = [0, 0];
  List<int>? updatedStartTimeRange;
  List<int>? updatedEndTimeRange;
  List<dynamic>? updatedImages = [];

  @override
  void initState() {
    super.initState();

    ownerCourtsCubit = context.read<OwnerCourtsCubit>();
    footballCourt = widget.footballCourt;
    nameController.text = footballCourt.name;
    peoplePriceController.text = footballCourt.pricePerHour.toString();

    for (int i = 0; i < footballCourt.pics.length; i++) {
      updatedImages?.add([footballCourt.pics[i], 0]);
    }

    updatedTime[0] = footballCourt.time[0];
    updatedTime[1] = footballCourt.time[1];
  }

  @override
  void dispose() {
    nameController.dispose();
    peoplePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Court Details',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                Text(
                  'Update ${footballCourt.name} Informaiton',
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
                        nameController.text = footballCourt.name;
                        context.pop();
                      },
                      onDonePressed: () {
                        if (nameController.text.trim().isEmpty) {
                          return;
                        }
                        context.pop();
                      },
                      title: 'Update court name',
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'New court name',
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
                        title: 'Update Court Images',
                        onDonePressed: () => context.pop(),
                        onCancelPressed: () {
                          updatedImages?.clear();
                          for (int i = 0; i < footballCourt.pics.length; i++) {
                            updatedImages?.add([footballCourt.pics[i], 0]);
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
                          children:
                              //no image
                              updatedImages!.isEmpty
                                  ? [
                                      CachedNetworkImage(
                                        imageUrl: kPlaceholderImage,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            const GlobalLoadingImage(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: GColors.black,
                                          size: 40,
                                        ),
                                      )
                                    ]
                                  : List.generate(
                                      updatedImages!.length,
                                      (index) {
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kOuterRadius),
                                              //show existing images
                                              child: index <
                                                      footballCourt.pics.length
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          updatedImages![index]
                                                              [0],
                                                      fit: BoxFit.contain,
                                                      placeholder: (context,
                                                              url) =>
                                                          const GlobalLoadingImage(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error_outline,
                                                        color: GColors.black,
                                                        size: 40,
                                                      ),
                                                    )
                                                  //new local images
                                                  : (kIsWeb
                                                      ? Image.network(
                                                          updatedImages![index]
                                                              [0],
                                                          fit: BoxFit.contain,
                                                        )
                                                      : Image.file(
                                                          File(
                                                            updatedImages![
                                                                index][0],
                                                          ),
                                                          fit: BoxFit.contain,
                                                        )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  tooltip: updatedImages![index]
                                                              [1] ==
                                                          0
                                                      ? 'Remove'
                                                      : 'Add',
                                                  onPressed: () => setState(() {
                                                    if (updatedImages![index]
                                                            [1] ==
                                                        0) {
                                                      updatedImages![index][1] =
                                                          1;
                                                    } else {
                                                      updatedImages![index][1] =
                                                          0;
                                                    }
                                                  }),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            GColors.whiteShade3
                                                                .shade600),
                                                  ),
                                                  icon: Icon(
                                                    index <
                                                            footballCourt
                                                                .pics.length
                                                        ? updatedImages![index]
                                                                    [1] ==
                                                                0
                                                            ? Icons.link
                                                            : Icons
                                                                .link_off_outlined
                                                        : updatedImages![index]
                                                                    [1] ==
                                                                0
                                                            ? Icons
                                                                .folder_rounded
                                                            : Icons
                                                                .folder_off_rounded,
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
                          'Update court hours   ${updatedTime[0].toString().toTime} - ${updatedTime[1].toString().toTime}',
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
                              updatedTime[0] = footballCourt.time[0];
                              updatedTime[1] = footballCourt.time[1];
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
                      title: 'Update court date',
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
                //price per person
                SettingsCard(
                  text: 'Price per Hour',
                  icon: Icons.price_change_rounded,
                  onTap: () => context.dialog(
                    barrierDismissible: false,
                    pageBuilder: (context, _, __) => OwnerVenueUpdateDialog(
                      title: 'Update court price',
                      onDonePressed: () {
                        if (peoplePriceController.text.trim().isEmpty) {
                          return;
                        }
                        context.pop();
                      },
                      onCancelPressed: () {
                        peoplePriceController.text =
                            footballCourt.pricePerHour.toString();
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
            await ownerCourtsCubit.updateVenue(
              FootballCourt(
                //won't update
                id: footballCourt.id,
                latitude: footballCourt.latitude,
                longitude: footballCourt.longitude,
                rates: footballCourt.rates,
                isApproved: footballCourt.isApproved,
                isBeingApproved: footballCourt.isBeingApproved,
                ownerId: footballCourt.ownerId,
                ownerName: footballCourt.ownerName,
                city: footballCourt.city,
                stripeAccountId: footballCourt.stripeAccountId,
                //will update
                name: nameController.text,
                pics: footballCourt.pics,
                startDate: updatedStartTimeRange ?? footballCourt.startDate,
                endDate: updatedEndTimeRange ?? footballCourt.endDate,
                time: updatedTime,
                pricePerHour: double.parse(peoplePriceController.text),
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
                'Update Court',
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
