import 'package:events_jo/config/algorithms/image_for_string.dart';
import 'package:events_jo/config/enums/food_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_slider.dart';
import 'package:events_jo/features/owner/representation/components/food_card.dart';
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
    return Row(
      children: [
        //display meal or drink
        FoodCard(
          imageUrl: ImageForString.get(name, FoodType.drink),
          padding: EdgeInsets.zero,
          width: 110,
          height: 110,
        ),

        const SizedBox(width: 10),

        //main container
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toCapitalized,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                //top row
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: onCheckBoxChanged,
                        activeColor: GColors.royalBlue,
                        checkColor: GColors.whiteShade3,
                        side: BorderSide(
                          color: GColors.royalBlue,
                          width: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          disabledThumbColor: GColors.poloBlue,
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
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: isChecked
                            ? GColors.logoGradient
                            : GColors.disabledLogoGradient,
                      ),
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                  ],
                ),
                //bottom row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AnimatedAlign(
                    alignment:
                        isChecked ? Alignment.center : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 300),
                    child: Wrap(
                      children: [
                        Text(
                          'Price: ${price.toString()}JD  ',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isChecked ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            'Total: ${calculatedPrice.toString()}JD',
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
          ),
        ),
      ],
    );
  }
}
