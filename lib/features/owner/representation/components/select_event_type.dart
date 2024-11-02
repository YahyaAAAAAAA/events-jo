import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class SelectEventType extends StatelessWidget {
  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? onTap3;

  const SelectEventType({
    super.key,
    required this.selectedEventType,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  });

  final int selectedEventType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GlobalColors.logoGradient,
          ),
          size: 100,
        ),
        GradientText(
          'EventsJo for Owners',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GlobalColors.logoGradient,
          ),
          style: TextStyle(
            color: GlobalColors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          'Pick which type of event you would like to add',
          style: TextStyle(
            color: GlobalColors.poloBlue,
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
                color: GlobalColors.white,
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
                        color: GlobalColors.royalBlue,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        selectedEventType == 0
                            ? 'Wedding Venue'
                            : selectedEventType == 1
                                ? 'Farm'
                                : 'Football Court',
                        style: TextStyle(
                          color: GlobalColors.royalBlue,
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
                color: GlobalColors.royalBlue,
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GlobalColors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
              color: GlobalColors.white,
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
                    onTap: onTap1,
                    child: Text(
                      'Wedding Venue',
                      style: TextStyle(
                        color: GlobalColors.royalBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onTap2,
                    child: Text(
                      'Farm',
                      style: TextStyle(
                        color: GlobalColors.royalBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onTap3,
                    child: Text(
                      'Football Court',
                      style: TextStyle(
                        color: GlobalColors.royalBlue,
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
        const Spacer(flex: 2),
      ],
    );
  }
}
