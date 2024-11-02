import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/my_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final OwnerCubit ownerCubit;
  DateTimeRange? range;
  List<int> time = [0, 0];
  int selectedEventType = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    ownerCubit = context.read<OwnerCubit>();
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
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
        index: index,
        children: [
          //0
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick which type of event you would like to add',
                style: TextStyle(
                  color: MyColors.poloBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColoredBox(
                      color: MyColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              selectedEventType == 0
                                  ? CustomIcons.wedding
                                  : selectedEventType == 1
                                      ? CustomIcons.farm
                                      : CustomIcons.football,
                              color: MyColors.royalBlue,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              selectedEventType == 0
                                  ? 'Wedding Venue'
                                  : selectedEventType == 1
                                      ? 'Farm'
                                      : 'Football Court',
                              style: TextStyle(
                                color: MyColors.royalBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  PopupMenuButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: MyColors.royalBlue,
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(MyColors.white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        )),
                    color: MyColors.white,
                    position: PopupMenuPosition.under,
                    offset: const Offset(0, 20),
                    constraints: const BoxConstraints.tightFor(width: 150),
                    initialValue: 0,
                    tooltip: '',
                    popUpAnimationStyle: AnimationStyle(
                      duration: const Duration(milliseconds: 200),
                    ),
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          onTap: () => setState(() => selectedEventType = 0),
                          child: Text(
                            'Wedding Venue',
                            style: TextStyle(
                              color: MyColors.royalBlue,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () => setState(() => selectedEventType = 1),
                          child: Text(
                            'Farm',
                            style: TextStyle(
                              color: MyColors.royalBlue,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () => setState(() => selectedEventType = 2),
                          child: Text(
                            'Football Court',
                            style: TextStyle(
                              color: MyColors.royalBlue,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ],
          ),
          //1
          const Center(
            child: Text(
              'data',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: MyColors.white,
        ),
        padding: const EdgeInsets.all(20),
        child: OwnerPageNavigationBar(
          onPressedNext: () => setState(() => index += 1),
          onPressedBack: () => setState(() {
            if (index == 0) {
              Navigator.of(context).pop();
              return;
            }
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
