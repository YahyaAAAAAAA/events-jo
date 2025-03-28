import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueCreditCardForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 250,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 120,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Expire Date',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
              ),
              10.width,
              const SizedBox(
                width: 120,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
              ),
            ],
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 100,
            children: [
              Text(
                'Save card for later',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize - 2,
                ),
              ),
              const Switch(
                value: false,
                onChanged: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
