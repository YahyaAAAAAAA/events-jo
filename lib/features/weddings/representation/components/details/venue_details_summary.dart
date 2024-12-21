import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_checkout_card.dart';
import 'package:events_jo/features/weddings/representation/components/venue_bar.dart';
import 'package:flutter/material.dart';

class VenueDetailsSummary extends StatelessWidget {
  final WeddingVenue venue;
  final DateTime selectedDate;
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final List<WeddingVenueMeal> selectedMeals;
  final List<WeddingVenueDrink> selectedDrinks;
  final String selectedPaymentMethod;
  final void Function()? onPressedNext;
  final void Function()? onPressedBack;
  final void Function(String?)? onChanged;
  final double Function()? total;

  const VenueDetailsSummary({
    super.key,
    required this.venue,
    required this.selectedDate,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.selectedMeals,
    required this.selectedDrinks,
    required this.selectedPaymentMethod,
    required this.total,
    this.onPressedNext,
    this.onPressedBack,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        VenueCheckoutCard(
          title: venue.name,
          subtitle: venue.city,
          trailing: Icon(
            CustomIcons.map_marker,
            color: GColors.royalBlue,
          ),
        ),
        const SizedBox(height: 10),
        //date
        VenueCheckoutCard(
          title: 'Venue Date',
          trailing: Text(
            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        //start time
        VenueCheckoutCard(
          title: 'Venue Start Time',
          trailing: Text(
            '${selectedStartTime.hour.toString().toTimeWithMinutes(selectedStartTime.minute.toString())}',
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        //end time
        VenueCheckoutCard(
          title: 'Venue End Time',
          trailing: Text(
            '${selectedEndTime.hour.toString().toTimeWithMinutes(selectedEndTime.minute.toString())}',
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        Text(
          'Venue Meals',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          elevation: 0,
          color: GColors.white,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: selectedMeals.isNotEmpty ? selectedMeals.length : 1,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return selectedMeals.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '• ${selectedMeals[index].name}',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${selectedMeals[index].selectedAmount} •',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'No Meals Selected',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 20,
                      ),
                    );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Venue Drinks',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          elevation: 0,
          color: GColors.white,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: selectedDrinks.isNotEmpty ? selectedDrinks.length : 1,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return selectedDrinks.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '• ${selectedDrinks[index].name}',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${selectedDrinks[index].selectedAmount} •',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'No Meals Selected',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 20,
                      ),
                    );
            },
          ),
        ),
        const Divider(),
        Text(
          'Payment Method',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          color: GColors.white,
          child: ListTile(
            leading: Radio(
              value: 'Credit Card',
              groupValue: selectedPaymentMethod,
              activeColor: GColors.royalBlue,
              fillColor:
                  WidgetStateColor.resolveWith((states) => GColors.royalBlue),
              onChanged: onChanged,
            ),
            title: Text(
              'Credit Card',
              style: TextStyle(
                color: GColors.royalBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          color: GColors.white,
          child: ListTile(
            leading: Radio(
              value: 'Cash',
              groupValue: selectedPaymentMethod,
              activeColor: GColors.royalBlue,
              fillColor:
                  WidgetStateColor.resolveWith((states) => GColors.royalBlue),
              onChanged: onChanged,
            ),
            title: Text(
              'Cash',
              style: TextStyle(
                color: GColors.royalBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          title: Text(
            'Total',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: GColors.royalBlue,
            ),
          ),
          trailing: Text(
            '\$${total!()} JD',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: GColors.royalBlue,
            ),
          ),
        ),
        VenueBar(
          onPressedNext: onPressedNext,
          onPressedBack: onPressedBack,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
