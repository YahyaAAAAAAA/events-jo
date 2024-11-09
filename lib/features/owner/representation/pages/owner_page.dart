import 'dart:io';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/representation/components/map_dialog.dart';
import 'package:events_jo/features/location/representation/components/map_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/confirm_and_add_event_to_database.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/event_added_successfully.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/images_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_location.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_name.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_type.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_images.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_date.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_time.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

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
  //cubit
  late final OwnerCubit ownerCubit;

  //event name
  final TextEditingController nameController = TextEditingController();

  //current page in the stack
  int index = 0;

  //venue, farm or court
  int selectedEventType = 0;

  //event date and time
  DateTimeRange? range;
  List<int> time = [12, 12];

  //temp value for UI control
  int tempValueForTime = 0;

  //event coords
  double lat = 0;
  double long = 0;

  //init location incase the user cancel
  double initLat = 0;
  double initLong = 0;

  //empty marker for now
  late Marker marker;

  List<XFile> images = [];

  @override
  void initState() {
    super.initState();

    //get cubit
    ownerCubit = context.read<OwnerCubit>();

    //dev will use this for quick addition
    // lat = 31.863837903688133;
    // long = 35.89443320390641;

    //save location
    lat = widget.user!.latitude;
    long = widget.user!.longitude;

    //save initial location
    initLat = widget.user!.latitude;
    initLong = widget.user!.longitude;

    //set marker to user location
    marker = Marker(
      point: LatLng(
        lat,
        long,
      ),
      child: Icon(
        Icons.location_pin,
        color: GColors.black,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ownerCubit.emit(OwnerInitial());
  }

  //this shows map for the user/event location (CAN BE CHANGED)
  Future<Object?> showMapDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => StatefulBuilder(
        builder: (context, setState) => MapDialog(
          latitude: lat,
          longitude: long,
          marker: marker,
          onTap: (tapPoint, point) {
            setState(() {
              //update coords
              lat = point.latitude;
              long = point.longitude;

              //update marker
              marker = Marker(
                point: point,
                child: Icon(
                  Icons.location_pin,
                  color: GColors.black,
                ),
              );
            });
          },
          //bring coords and marker to init value
          onCancel: () {
            Navigator.of(context).pop();
            setState(
              () {
                lat = initLat;
                long = initLong;
                marker = Marker(
                  point: LatLng(lat, long),
                  child: Icon(
                    Icons.location_pin,
                    color: GColors.black,
                  ),
                );
              },
            );
          },
          //saves coords and marker new values
          onConfirm: () {
            setState(
              () {
                Navigator.of(context).pop();
                initLat = lat;
                initLong = long;
                marker = Marker(
                  point: LatLng(lat, long),
                  child: Icon(
                    Icons.location_pin,
                    color: GColors.black,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  //this shows map for the user/event location (CANNOT BE CHANGED)
  Future<Object?> showMapDialogPreview(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => MapDialogPreview(
        latitude: lat,
        longitude: long,
        marker: marker,
      ),
    );
  }

  //this shows user's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<XFile> images) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ImagesDialogPreview(images: imagesFilesToWidgets(images)),
    );
  }

  //convert files -> images
  List<Widget> imagesFilesToWidgets(List<XFile> images) {
    List<Widget> imagesWidgets = [];
    imagesWidgets.clear();
    for (int i = 0; i < images.length; i++) {
      imagesWidgets.add(
        Image.file(
          File(images[i].path),
          fit: BoxFit.cover,
        ),
      );
    }

    return imagesWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //disables native back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          //hides back button
          leading: SizedBox(),
          centerTitle: true,
          title: Text(
            '( ${(index + 1).toString()}/7 )',
            style: TextStyle(
              color: GColors.poloBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: LazyIndexedStack(
          index: index,
          children: [
            //type
            SelectEventType(
              selectedEventType: selectedEventType,
              onTap1: () => setState(() => selectedEventType = 0),
              onTap2: () => setState(() => selectedEventType = 1),
              onTap3: () => setState(() => selectedEventType = 2),
            ),

            //name
            SelectEventName(
              selectedEventType: selectedEventType,
              nameController: nameController,
            ),

            //location
            SelectEventLocation(
              selectedEventType: selectedEventType,
              onPressed: () => showMapDialog(context),
            ),

            //pics
            SelectImages(
              images: images,
              selectedEventType: selectedEventType,
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

            //date range
            SelectRangeDate(
              range: range,
              onRangeSelected: (value) => setState(() => range = value),
            ),

            //time range
            SelectRangeTime(
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

            //* submit
            submitEvent(),
          ],
        ),
        //watch the state here to hide the bar when loading
        bottomNavigationBar: BlocConsumer<OwnerCubit, OwnerStates>(
          builder: (context, state) {
            if (state is OwnerInitial) {
              return OwnerPageNavigationBar(
                index: index,
                onPressedNext: () => setState(() {
                  //if no name provided
                  if (index == 1) {
                    if (nameController.text.isEmpty) {
                      GSnackBar.show(
                          context: context, text: 'Please enter a name');
                      return;
                    }
                  }
                  //if no date range provided
                  if (index == 4) {
                    if (range == null) {
                      GSnackBar.show(
                          context: context,
                          text: 'Please enter a range of date');
                      return;
                    }
                  }

                  //if no time range provided
                  if (index == 5) {
                    if (tempValueForTime == 0) {
                      GSnackBar.show(
                          context: context,
                          text: 'Please enter a range of time');
                      return;
                    }
                  }

                  //last page
                  if (index == 6) {
                    return;
                  }

                  //next page
                  index += 1;
                }),
                onPressedBack: () => setState(() {
                  //if no more pages (go home)
                  if (index == 0) {
                    Navigator.of(context).pop();
                    return;
                  }

                  //previous page
                  index -= 1;
                }),
              );
            } else {
              return SizedBox();
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

  BlocConsumer<OwnerCubit, OwnerStates> submitEvent() {
    return BlocConsumer<OwnerCubit, OwnerStates>(
      builder: (context, state) {
        //initial
        if (state is OwnerInitial) {
          return ConfirmAndAddEventToDatabase(
            selectedEventType: selectedEventType,
            nameController: nameController,
            range: range,
            time: time,
            showMap: () => showMapDialogPreview(context),
            showImages: () => showImagesDialogPreview(context, images),
            onPressed: () async {
              List<String> urls = [];
              urls.clear();

              //if user selected images
              if (images.isNotEmpty) {
                urls = await ownerCubit.addImagesToServer(images);
              }

              await ownerCubit.addVenueToDatabase(
                name: nameController.text,
                lat: lat.toString(),
                lon: long.toString(),
                pics: images.isNotEmpty ? urls : null,
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
                ownerId: widget.user!.uid,
              );
            },
          );
        }

        //done
        if (state is OwnerLoaded) {
          return EventAddedSuccessfully(
            selectedEventType: selectedEventType,
            onPressed: () => Navigator.of(context).pop(),
          );
        }
        //loading...
        else {
          return const LoadingIndicator();
        }
      },
      listener: (context, state) {
        //notify user when (image uploading) and (event uploading)
        if (state is OwnerLoading) {
          GSnackBar.show(
              context: context,
              text: state.messege,
              duration: Duration(seconds: 1));
        }
        //error
        if (state is OwnerError) {
          GSnackBar.show(context: context, text: state.message);
        }
      },
    );
  }
}
