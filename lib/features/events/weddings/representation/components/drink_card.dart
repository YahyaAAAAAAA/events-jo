import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:events_jo/features/owner/representation/components/creation/food_card.dart';

class DrinkCard extends StatelessWidget {
  final bool isChecked;
  final String name;
  final int amount;
  final double price;
  final double calculatedPrice;
  final int selectedAmount;
  final void Function(bool?)? onCheckBoxChanged;
  final void Function(double)? onSliderChanged;

  const DrinkCard({
    super.key,
    required this.isChecked,
    required this.name,
    required this.amount,
    required this.selectedAmount,
    required this.onCheckBoxChanged,
    required this.onSliderChanged,
    required this.price,
    required this.calculatedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  FoodCard(
                    imageUrl: ImageForString.get(name, FoodType.drink),
                    padding: EdgeInsets.zero,
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    width: 60,
                    child: Center(
                      child: Tooltip(
                        message: name.toCapitalized,
                        child: Text(
                          name.toCapitalized,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize - 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                endIndent: 20,
                indent: 0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            value: isChecked,
                            onChanged: onCheckBoxChanged,
                            activeColor: GColors.royalBlue,
                            checkColor: GColors.whiteShade3,
                            side: BorderSide(
                              color: GColors.royalBlue,
                              width: 0.7,
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: Slider(
                            padding: const EdgeInsets.all(0),
                            value: selectedAmount.toDouble(),
                            min: 1,
                            max: amount.toDouble(),
                            thumbColor: GColors.royalBlue,
                            activeColor: GColors.royalBlue,
                            inactiveColor: GColors.poloBlue,
                            label: selectedAmount.toInt().toString(),
                            divisions: amount.toInt(),
                            onChanged: isChecked ? onSliderChanged : null,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kOuterRadius),
                            color: GColors.whiteShade3.shade600,
                          ),
                          width: 45,
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              selectedAmount.toInt().toString(),
                              style: TextStyle(
                                color: isChecked
                                    ? GColors.royalBlue
                                    : GColors.royalBlue.shade200,
                                fontSize: kSmallFontSize - 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Wrap(
                      children: [
                        Text(
                          'Price: ${price.toString()}JD  ',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isChecked ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            'Total: ${calculatedPrice.toString()}JD',
                            style: TextStyle(
                              fontSize: kSmallFontSize,
                              color: GColors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
