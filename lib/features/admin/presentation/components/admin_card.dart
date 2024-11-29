import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String name;
  final String owner;
  final int index;
  final bool isApproved;
  final void Function()? onPressed;

  const AdminCard({
    super.key,
    required this.name,
    required this.index,
    required this.owner,
    required this.isApproved,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        //note: to display vertical divider
        child: IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              VerticalDivider(
                color: GColors.whiteShade3,
                thickness: 7,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_4_rounded,
                          color: GColors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          owner,
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: isApproved
                              ? GColors.greenShade3
                              : GColors.redShade3,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isApproved ? 'Approved' : 'Not Approved',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AdminButton(
                onPressed: onPressed,
              ), //todo add on pressed
            ],
          ),
        ),
      ),
    );
  }
}
