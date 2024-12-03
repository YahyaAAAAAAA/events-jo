import 'package:events_jo/config/algorithms/icon_for_string.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_slider.dart';
import 'package:events_jo/features/owner/data/firebase_owner_repo.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: isChecked,
                  onChanged: onCheckBoxChanged,
                  activeColor: GColors.royalBlue,
                  checkColor: GColors.whiteShade3,
                  side: BorderSide(color: GColors.royalBlue, width: 2),
                ),
              ),
              //IFS algo tries to find a suitable icon for a name
              //if not available , replace icon with SizedBox
              IconForString.get(name) != null
                  ? Icon(
                      IconForString.get(name),
                      color: GColors.royalBlue,
                    )
                  : const SizedBox(),
              const SizedBox(width: 5),
              Text(
                name.toCapitalized,
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 21,
                ),
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: isChecked ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackShape: GradientRectSliderTrackShape(
                        gradient: GColors.logoGradient,
                        darkenInactive: true,
                      ),
                    ),
                    child: Slider(
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
                ),
              ),
              AnimatedOpacity(
                opacity: isChecked ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: GColors.logoGradient,
                  ),
                  width: 50,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      selectedAmount.toInt().toString(),
                      style: TextStyle(
                        color: GColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AnimatedAlign(
              alignment: isChecked ? Alignment.center : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Price per piece: ${price.toString()}JD  ',
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isChecked ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '  Total price: ${calculatedPrice.toString()}JD',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
