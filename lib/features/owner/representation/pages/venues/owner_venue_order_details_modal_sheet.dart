import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class OwnerVenueOrderDetailsModalSheet extends StatelessWidget {
  final WeddingVenue? venue;
  final EOrder order;
  final List<WeddingVenueMeal>? meals;
  final List<WeddingVenueDrink>? drinks;
  final void Function()? onOrderCancelPressed;
  final void Function()? onOrderConfirmPressed;

  const OwnerVenueOrderDetailsModalSheet({
    super.key,
    required this.venue,
    required this.order,
    this.meals,
    this.drinks,
    this.onOrderCancelPressed,
    this.onOrderConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topRow(),
            FittedBox(
              child: Row(
                spacing: 10,
                children: [
                  timeContainer(),
                  expectedPeopleContainer(),
                ],
              ),
            ),
            Text(
              '• Meals',
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
            mealsContainer(),
            Text(
              '• Drinks',
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
            drinksContainer(),
            const Divider(),
            order.status == OrderStatus.pending
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: onOrderCancelPressed,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.redShade3.withValues(alpha: 0.3),
                          ),
                        ),
                        icon: Text(
                          'Cancel Order ?',
                          style: TextStyle(
                            color: GColors.redShade3.shade800,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onOrderConfirmPressed,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.greenShade3.withValues(alpha: 0.3),
                          ),
                        ),
                        icon: Text(
                          'Confirm Order',
                          style: TextStyle(
                            color: GColors.greenShade3.shade800,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Order Done',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3.shade600,
                          ),
                        ),
                        icon: Text(
                          'Go Back',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Container drinksContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(kOuterRadius),
      ),
      child: drinks!.isEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                const Icon(
                  Icons.local_drink_rounded,
                ),
                Text(
                  'No Drinks were ordered',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              ],
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: drinks!.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const VerticalDivider();
              },
              itemBuilder: (context, index) => Center(
                child: Text(
                  'Drink: ${drinks![index].name}, Amount: ${drinks![index].amount}',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              ),
            ),
    );
  }

  Container mealsContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(kOuterRadius),
      ),
      child: meals!.isEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                const Icon(
                  Icons.soup_kitchen_rounded,
                ),
                Text(
                  'No Meals were orderd',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              ],
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: meals!.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const VerticalDivider();
              },
              itemBuilder: (context, index) => Center(
                child: Text(
                  'Meal: ${meals![index].name}, Amount: ${meals![index].amount}',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              ),
            ),
    );
  }

  Container expectedPeopleContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(
          kOuterRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              const Icon(
                Icons.chair,
                size: kSmallIconSize,
              ),
              Text(
                'Expected People: ${order.people}',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 150,
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              const Icon(
                Icons.access_time_filled_rounded,
                size: kSmallIconSize,
              ),
              Text(
                'Created At: ${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container timeContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(
          kOuterRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              const Icon(
                CustomIcons.calendar_clock,
                size: kSmallIconSize,
              ),
              Text(
                'Start Time: ${order.startTime.toString().toTime}',
                style:
                    TextStyle(color: GColors.black, fontSize: kSmallFontSize),
              ),
            ],
          ),
          const SizedBox(
            width: 120,
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              const Icon(
                CustomIcons.calendar,
                size: kSmallIconSize,
              ),
              Text(
                'Finish Time: ${order.endTime.toString().toTime}',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topRow() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: kListViewWidth,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // spacing: 70,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GColors.whiteShade3.shade600,
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.person_outline_outlined,
                    size: kNormalIconSize,
                    color: GColors.royalBlue,
                  ),
                ),
                Text(
                  'Contact your customer',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kNormalFontSize,
                  ),
                ),
              ],
            ),
            IconButton(
              //todo message user
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              ),
              icon: Icon(
                Icons.message_outlined,
                color: GColors.white,
                size: kSmallIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
