import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:events_jo/features/weddings/representation/components/venue_details_button.dart';
import 'package:events_jo/features/weddings/representation/components/venues_app_bar.dart';
import 'package:flutter/material.dart';

class VenueChanged extends StatelessWidget {
  const VenueChanged({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VenuesAppBar(user: null),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: [
            Center(
              child: VenueDetailsButton(
                icon: Icons.restart_alt_rounded,
                iconSize: 40,
                padding: 20,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: GradientText(
                  'Something has changed, please rejoin',
                  gradient: GColors.logoGradient,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
