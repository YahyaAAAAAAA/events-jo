import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:flutter/material.dart';

class StripeNotCompletedPage extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;

  const StripeNotCompletedPage({
    super.key,
    this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const GlobalLoadingBar(mainText: false)
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kOuterRadius),
              color: GColors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Waiting for connection completion',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                      ),
                    ),
                    Icon(
                      Icons.refresh_outlined,
                      color: GColors.black,
                      size: kBigIconSize,
                    ),
                  ],
                ),
                const Divider(
                  endIndent: 0,
                  indent: 0,
                ),
                10.height,
                Text(
                  'Please complete your Stripe account connection to proceed.',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
                50.height,
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.whiteShade3.shade600),
                    ),
                    icon: Text(
                      'Reconnect Account',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
