import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminUsersCard extends StatelessWidget {
  final String name;
  final int index;
  final bool isOnline;
  final bool isLoading;
  final void Function()? onPressed;

  const AdminUsersCard({
    super.key,
    required this.name,
    required this.index,
    required this.isOnline,
    required this.isLoading,
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
          border: Border(
            left: BorderSide(
              color: isLoading ? GColors.white : GColors.cyanShade6,
              width: 10,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: GColors.cyan.withOpacity(0.2),
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
                          Icons.circle,
                          color: isOnline
                              ? GColors.greenShade3
                              : GColors.redShade3,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isOnline ? 'Online' : 'Offline',
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
                isLoading: isLoading,
                padding: const EdgeInsets.all(10),
                buttonPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                icon: Icons.info_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
