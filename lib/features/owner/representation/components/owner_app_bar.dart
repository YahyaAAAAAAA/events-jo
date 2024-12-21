import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int index;
  const OwnerAppBar({
    super.key,
    required this.index,
  });

  @override
  State<OwnerAppBar> createState() => _OwnerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OwnerAppBarState extends State<OwnerAppBar> {
  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    //generate list
    list = List.generate(
      11,
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
    return AppBar(
      //hides back button
      leading: const SizedBox(),
      leadingWidth: 0,
      //note: remove appbar color when scrolling
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: list,
        ),
      ),
    );
  }
}
