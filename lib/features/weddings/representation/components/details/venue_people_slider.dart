import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_slider.dart';
import 'package:events_jo/features/weddings/representation/components/venue_details_button.dart';
import 'package:flutter/material.dart';

class VenuePeopleSlider extends StatelessWidget {
  final double padding;
  final double numberOfExpectedPeople;
  final String numberOfExpectedPeopleText;
  final void Function(double)? onChanged;

  const VenuePeopleSlider({
    super.key,
    required this.onChanged,
    required this.padding,
    required this.numberOfExpectedPeople,
    required this.numberOfExpectedPeopleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: GradientRectSliderTrackShape(
                  gradient: LinearGradient(
                    colors: GColors.logoGradient,
                  ),
                  darkenInactive: true,
                ),
              ),
              child: Slider(
                min: 0, //get from db
                max: 100, //get from db
                thumbColor: GColors.royalBlue,
                value: numberOfExpectedPeople,
                activeColor: GColors.royalBlue,
                inactiveColor: GColors.poloBlue,
                label: numberOfExpectedPeopleText,
                divisions: 100, //this should be max value
                onChanged: onChanged,
              ),
            ),
          ),
          VenueDetailsButton(
            onPressed: () {
              //todo this should be a pop up
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: GColors.whiteShade3,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Number of Expected People for your Venue: ' +
                                numberOfExpectedPeopleText,
                            style: TextStyle(
                              color: GColors.royalBlue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icons.chair,
            iconSize: 30,
            padding: 18,
          ),
        ],
      ),
    );
  }
}
