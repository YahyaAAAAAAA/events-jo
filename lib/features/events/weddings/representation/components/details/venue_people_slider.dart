import 'dart:ui';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/double_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenuePeopleSlider extends StatelessWidget {
  final int min;
  final int max;
  final int numberOfExpectedPeople;
  final double pricePerPerson;
  final void Function(double)? onChanged;

  const VenuePeopleSlider({
    super.key,
    required this.onChanged,
    required this.numberOfExpectedPeople,
    required this.pricePerPerson,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // alignment: WrapAlignment.start,
        // crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(GColors.whiteShade3.shade600),
            ),
            icon: Icon(
              Icons.chair,
              size: kSmallIconSize,
              color: GColors.royalBlue,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.zero),
                                  backgroundColor: WidgetStatePropertyAll(
                                      GColors.royalBlue)),
                              icon: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: GColors.logoGradient,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.clear,
                                    color: GColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.transparent,
                        content: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: GColors.whiteShade3,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '• The price per person: ${pricePerPerson.toString()}JD',
                                          style: TextStyle(
                                            color: GColors.royalBlue,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '• The number people expected: ${numberOfExpectedPeople.toString()}',
                                          style: TextStyle(
                                            color: GColors.royalBlue,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '• The total price: ${(numberOfExpectedPeople * pricePerPerson).toPrecision(2)}JD',
                                          style: TextStyle(
                                            color: GColors.royalBlue,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Expanded(
            child: Transform.scale(
              scale: 0.7,
              child: Slider(
                padding: const EdgeInsets.all(0),
                min: min.toDouble(),
                max: max.toDouble(),
                value: numberOfExpectedPeople.toDouble(),
                thumbColor: GColors.royalBlue,
                activeColor: GColors.royalBlue,
                inactiveColor: GColors.poloBlue,
                label: numberOfExpectedPeople.toString(),
                divisions: 100, //this should be max value
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
