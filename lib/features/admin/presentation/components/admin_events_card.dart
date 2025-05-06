import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminEventsCard extends StatelessWidget {
  final String name;
  final String owner;
  final int index;
  final bool isApproved;
  final bool isBeingApproved;
  final bool isLoading;
  final void Function()? onPressed;

  const AdminEventsCard({
    super.key,
    required this.name,
    required this.index,
    required this.owner,
    required this.isApproved,
    required this.isBeingApproved,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kListViewWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: IconButton(
            onPressed: onPressed,
            icon: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    CustomIcons.wedding,
                    size: kNormalFontSize,
                    color: GColors.cyanShade6,
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kNormalIconSize - 3,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person_4_rounded,
                            color: GColors.black,
                            size: kSmallIconSize,
                          ),
                          5.width,
                          Text(
                            owner,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                          5.width,
                          Icon(
                            Icons.circle,
                            color: isApproved
                                ? GColors.greenShade3
                                : GColors.redShade3,
                            size: kSmallIconSize - 3,
                          ),
                          5.width,
                          Text(
                            isApproved ? 'Approved' : 'Not Approved',
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
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
                    AdminButton(
                        onPressed: onPressed,
                        isLoading: isLoading,
                        icon: Icons.info_outline_rounded,
                      )
                    //venue is being reviewed
                    : AdminButton(
                        onPressed: () => GSnackBar.show(
                          context: context,
                          text: 'The venue is being approved by another admin',
                          color: GColors.cyanShade6,
                          gradient: GColors.adminGradient,
                        ),
                        isLoading: isLoading,
                        icon: Icons.lock_person_outlined,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
