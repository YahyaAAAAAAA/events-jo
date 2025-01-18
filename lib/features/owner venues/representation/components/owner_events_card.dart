import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/owner%20venues/representation/components/owner_events_button.dart';
import 'package:flutter/material.dart';

class OwnerEventsCard extends StatelessWidget {
  final String name;
  final String owner;
  final int index;
  final bool isApproved;
  final bool isBeingApproved;
  final bool isLoading;
  final IconData icon;
  final void Function()? onPressed;

  const OwnerEventsCard({
    super.key,
    required this.name,
    required this.index,
    required this.owner,
    required this.isApproved,
    required this.isBeingApproved,
    required this.isLoading,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: isLoading ? GColors.white : GColors.royalBlue,
                  width: 10,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: GColors.royalBlue.withValues(alpha: 0.2),
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
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
                    thickness: 5,
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
                  !isBeingApproved
                      ?
                      //venue is open to review
                      OwnerEventsButton(
                          onPressed: onPressed,
                          isLoading: isLoading,
                          padding: const EdgeInsets.all(15),
                          buttonPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          icon: icon,
                        )
                      //venue is being reviewed
                      : OwnerEventsButton(
                          onPressed: () => GSnackBar.show(
                            context: context,
                            text:
                                'The venue is being approved by another admin',
                            color: GColors.royalBlue,
                            gradient: GColors.logoGradient,
                          ),
                          isLoading: isLoading,
                          padding: const EdgeInsets.all(15),
                          buttonPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          icon: Icons.lock_person_outlined,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
