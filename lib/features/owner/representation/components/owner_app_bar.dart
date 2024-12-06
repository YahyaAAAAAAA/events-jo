import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerAppBar extends StatefulWidget {
  final int index;
  const OwnerAppBar({
    super.key,
    required this.index,
  });

  @override
  State<OwnerAppBar> createState() => _OwnerAppBarState();
}

class _OwnerAppBarState extends State<OwnerAppBar> {
  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    //generate list
    list = List.generate(
      10,
      (index) {
        if (index == 0) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 30,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GColors.royalBlue,
            ),
          );
        } else {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GColors.poloBlue,
            ),
          );
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant OwnerAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    //reset prev index
    list[oldWidget.index] = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 20,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.poloBlue,
      ),
    );

    //update current index
    list[widget.index] = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 30,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.royalBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }
}
