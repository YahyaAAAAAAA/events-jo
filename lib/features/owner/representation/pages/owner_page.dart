import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/confirm_and_add_event_to_database_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/event_added_successfully_page.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_location_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_name_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_event_type_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_images_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_date_page.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_time_page.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

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
  //cubit instance
  late final OwnerCubit ownerCubit;

  late final LocationCubit locationCubit;

  //owner instance (mostly location related)
  late final UserLocation userLocation;

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

  //images list
  List<XFile> images = [];

  //note for cubit ->
  //    (pass by reference)
  //1- create a non-primitive type (eg: an Entity)
  //    (to reflect changes to UI)
  //2- emit (loading) and (loaded) states
  //3- bloc builder & consumer
  //if you pass a primitive type (int,double, etc..)
  //they get passed by (value) so changes will not reflect

  @override
  void initState() {
    super.initState();

    //get cubits
    ownerCubit = context.read<OwnerCubit>();
    locationCubit = context.read<LocationCubit>();

    //todo will use this for quick addition
    // lat = 31.863837903688133;
    // long = 35.89443320390641;

    //setup user location values
    userLocation = UserLocation(
      lat: widget.user!.latitude,
      long: widget.user!.longitude,
      initLat: widget.user!.latitude,
      initLong: widget.user!.longitude,
      marker: Marker(
        point: LatLng(
          widget.user!.latitude,
          widget.user!.longitude,
        ),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ownerCubit.emit(OwnerInitial());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //disables native back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          //hides back button
          leading: const SizedBox(),
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
            //* owner sub pages

            //type
            SelectEventType(
              selectedEventType: selectedEventType,
              onTap1: () => setState(() => selectedEventType = 0),
              onTap2: () => setState(() => selectedEventType = 1),
              onTap3: () => setState(() => selectedEventType = 2),
            ),

            //name
            SelectEventNamePage(
              selectedEventType: selectedEventType,
              nameController: nameController,
            ),

            //location
            SelectEventLocationPage(
              selectedEventType: selectedEventType,
              onPressed: () => locationCubit.showMapDialog(context,
                  userLocation: userLocation),
            ),

            //pics
            SelectImagesPage(
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

            //* submit
            submitEvent(),
          ],
        ),
        //watch the state here to hide the bar when loading
        bottomNavigationBar: BlocConsumer<OwnerCubit, OwnerStates>(
          builder: (context, state) {
            //user haven't submitted yet
            if (state is OwnerInitial) {
              return OwnerPageNavigationBar(
                index: index,
                //this method checks user input and control current page
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
          return ConfirmAndAddEventToDatabasePage(
            selectedEventType: selectedEventType,
            nameController: nameController,
            range: range,
            time: time,
            showMap: () => locationCubit.showMapDialogPreview(context,
                userLocation: userLocation),
            showImages: () =>
                ownerCubit.showImagesDialogPreview(context, images),
            onPressed: () async {
              List<String> urls = [];
              urls.clear();

              //if user selected images
              if (images.isNotEmpty) {
                urls = await ownerCubit.addImagesToServer(images);
              }

              //call cubit
              await ownerCubit.addVenueToDatabase(
                name: nameController.text,
                lat: userLocation.lat.toString(),
                lon: userLocation.long.toString(),
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
          return EventAddedSuccessfullyPage(
            selectedEventType: selectedEventType,
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
          return const LoadingIndicator();
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
