import 'package:events_jo/config/algorithms/icon_for_string.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_slider.dart';
import 'package:events_jo/features/owner/data/firebase_owner_repo.dart';
import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final bool isChecked;
  final String name;
  final double amount;
  final double selectedAmount;
  final void Function(bool?)? onCheckBoxChanged;
  final void Function(double)? onSliderChanged;

  const MealCard({
    super.key,
    required this.isChecked,
    required this.name,
    required this.amount,
    required this.selectedAmount,
    required this.onCheckBoxChanged,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
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
            Icon(
              IconForString.get(name),
              color: GColors.royalBlue,
            ),
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
                      gradient: LinearGradient(
                        colors: GColors.logoGradient,
                      ),
                      darkenInactive: true,
                    ),
                  ),
                  child: Slider(
                    value: selectedAmount,
                    min: 0,
                    max: amount,
                    thumbColor: GColors.royalBlue,
                    activeColor: GColors.royalBlue,
                    inactiveColor: GColors.poloBlue,
                    label: selectedAmount.toInt().toString(),
                    divisions: amount.toInt(),
                    onChanged: onSliderChanged,
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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: GColors.logoGradient,
                  ),
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
      ),
    );
  }
}
