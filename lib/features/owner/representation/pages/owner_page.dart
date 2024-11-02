import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/representation/components/map_dialog.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/components/select_event_locaiton.dart';
import 'package:events_jo/features/owner/representation/components/select_event_name.dart';
import 'package:events_jo/features/owner/representation/components/select_event_type.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
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
  final TextEditingController nameController = TextEditingController();
  late final OwnerCubit ownerCubit;
  DateTimeRange? range;
  List<int> time = [0, 0];
  int selectedEventType = 0;
  int index = 0;

  Position? location;

  //users coords
  double lat = 0;
  double long = 0;
  //init location incase the user cancel
  double initLat = 0;
  double initLong = 0;

  //empty marker for now
  late Marker marker;

  @override
  void initState() {
    super.initState();
    ownerCubit = context.read<OwnerCubit>();

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
        color: GlobalColors.black,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    //todo cubit
  }

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
                  color: GlobalColors.black,
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
                    color: GlobalColors.black,
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
                    color: GlobalColors.black,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  //dev remove both buttons
  // TextButton(
  //   onPressed: () async {
  //     date = await showDatePickerDialog(
  //       context: context,
  //       minDate: range!.start,
  //       maxDate: range!.end,
  //     );
  //     setState(() {});
  //   },
  //   child: const Text('temp'),
  // ),
  // TextButton(
  //   onPressed: () async {
  //     TimeOfDay? t = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),
  //       initialEntryMode: TimePickerEntryMode.dialOnly,
  //     );
  //     date = DateTime(
  //       date!.year,
  //       date!.month,
  //       date!.day,
  //       t!.hour,
  //       t.minute,
  //     );
  //     print(date!.hour);
  //     setState(() {});
  //   },
  //   child: const Text('temp'),
  // ),

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //todo same method as back button
      // canPop: false,
      // onPopInvokedWithResult: (didPop, result) => setState(() {
      //   if (index == 0) {
      //     print('object');
      //   } else {
      //     index -= 1;
      //   }
      // }),
      child: Scaffold(
        appBar: AppBar(),
        body: IndexedStack(
          index: index,
          children: [
            //type
            SelectEventType(
              selectedEventType: selectedEventType,
              onTap1: () => setState(() => selectedEventType = 0),
              onTap2: () => setState(() => selectedEventType = 1),
              onTap3: () => setState(() => selectedEventType = 2),
            ),

            //location
            SelectEventName(
              selectedEventType: selectedEventType,
              nameController: nameController,
            ),

            //location
            SelectEventLocation(
              selectedEventType: selectedEventType,
              onPressed: () => showMapDialog(context),
            ),

            //scehdule (date and time togther or seperated)

            //pics

            //submit
          ],
        ),
        bottomNavigationBar: OwnerPageNavigationBar(
          onPressedNext: () => setState(() {
            //if no name provided
            if (index == 1) {
              if (nameController.text.isEmpty) {
                GlobalSnackBar.show(
                    context: context, text: 'Please enter a name');
                return;
              }
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
        ),
      ),
    );
  }

  BlocConsumer<OwnerCubit, OwnerStates> submitEvent() {
    return BlocConsumer<OwnerCubit, OwnerStates>(
      builder: (context, state) {
        if (state is OwnerInitial) {
          return TextButton(
            onPressed: () async => await ownerCubit.addVenueToDatabase(
              name: 'TT',
              lat: '0',
              lon: '0',
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
            ),
            child: const Text('Add to db'),
          );
        }
        if (state is OwnerLoaded) {
          return const Text('Done');
        } else {
          return const CircularProgressIndicator();
        }
      },
      listener: (context, state) {
        // todo: implement listener
      },
    );
  }
}
