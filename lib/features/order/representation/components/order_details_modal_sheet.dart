import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsModalSheet extends StatelessWidget {
  final WeddingVenue? venue;
  final EOrder order;
  final List<WeddingVenueMeal>? meals;
  final List<WeddingVenueDrink>? drinks;

  const OrderDetailsModalSheet({
    super.key,
    required this.venue,
    required this.order,
    this.meals,
    this.drinks,
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
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3,
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
                      IconButton(
                        //todo
                        onPressed: () async {
                          context.pop();
                          await context.read<OrderCubit>().updateOrderStatus(
                                'userId',
                                order.userId,
                                order.id,
                                OrderStatus.canceled,
                                cache: true,
                              );
                        },
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(kOuterRadius),
                  child: CachedNetworkImage(
                    imageUrl: venue?.pics[0],
                    placeholder: (context, url) => const GlobalLoadingImage(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: GColors.black,
                      size: 40,
                    ),
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue == null ? 'Name not fount' : venue!.name,
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                    Text(
                      venue == null
                          ? 'Owner not fount'
                          : 'Owner name: ${venue!.ownerName}',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 5,
              children: [
                IconButton(
                  //todo message venue owner
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(GColors.whiteShade3.shade600),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  icon: Icon(
                    Icons.message_outlined,
                    color: GColors.royalBlue,
                    size: kSmallIconSize,
                  ),
                ),
                IconButton(
                  onPressed:
                      //todo show location
                      () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(GColors.whiteShade3.shade600),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  icon: Icon(
                    CustomIcons.map_marker,
                    color: GColors.royalBlue,
                    size: kSmallIconSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
