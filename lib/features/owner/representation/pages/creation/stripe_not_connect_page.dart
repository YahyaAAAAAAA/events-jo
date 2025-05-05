import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class StripeNotConnectedPage extends StatelessWidget {
  final void Function()? onPressed;

  const StripeNotConnectedPage({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Connect Stripe account',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kNormalFontSize,
                ),
              ),
              Icon(
                Icons.account_balance_rounded,
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
            'Before you can start creating and managing events, you need to connect us to your Stripe account.',
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
                backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
              ),
              icon: Text(
                'Connect Account',
                style: TextStyle(
                  color: GColors.white,
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
