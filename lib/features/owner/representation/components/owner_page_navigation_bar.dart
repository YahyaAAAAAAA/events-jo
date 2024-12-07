import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerPageNavigationBar extends StatelessWidget {
  final void Function()? onPressedNext;
  final void Function()? onPressedBack;
  final int index;
  const OwnerPageNavigationBar({
    super.key,
    required this.onPressedNext,
    required this.onPressedBack,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      decoration: BoxDecoration(
        borderRadius: index != 9
            ? const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : null,
        boxShadow: index != 9
            ? [
                BoxShadow(
                  color: GColors.royalBlue.withOpacity(0.5),
                  blurRadius: 7,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
        color: GColors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //back button
          Row(
            children: [
              IconButton(
                onPressed: onPressedBack,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                    shadowColor: WidgetStatePropertyAll(
                      GColors.black.withOpacity(0.5),
                    ),
                    elevation: const WidgetStatePropertyAll(3),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
                icon: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: GColors.logoGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: GColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Back',
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          //next button
          index != 9
              ? Row(
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: onPressedNext,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(GColors.royalBlue),
                          shadowColor: WidgetStatePropertyAll(
                            GColors.black.withOpacity(0.5),
                          ),
                          elevation: const WidgetStatePropertyAll(3),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero)),
                      icon: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: GColors.logoGradient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            color: GColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              //last page
              : Row(
                  children: [
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(GColors.royalBlue),
                          shadowColor: WidgetStatePropertyAll(
                            GColors.black.withOpacity(0.5),
                          ),
                          elevation: const WidgetStatePropertyAll(3),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero)),
                      icon: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: GColors.logoGradient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            Icons.clear,
                            size: 30,
                            color: GColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
