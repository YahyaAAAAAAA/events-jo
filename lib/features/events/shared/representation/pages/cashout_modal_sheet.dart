import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/unique.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/events/weddings/representation/components/details/venue_credit_card_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashoutModalSheet extends StatelessWidget {
  final EventType eventType;
  final double totalAmount;
  final String paymentMethod;
  final String userId;
  final String ownerId;
  final String venueId;
  final DateTime? date;
  final int startTime;
  final int endTime;
  final int people;
  final List<WeddingVenueMeal>? meals;
  final List<WeddingVenueDrink>? drinks;
  final bool isRefundable;
  final void Function(bool)? onRefundableChanged;

  const CashoutModalSheet({
    super.key,
    required this.eventType,
    required this.paymentMethod,
    required this.totalAmount,
    required this.userId,
    required this.ownerId,
    required this.venueId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.people,
    required this.isRefundable,
    this.onRefundableChanged,
    this.meals,
    this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is OrderError) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        if (state is OrderAdded) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          width: 100,
                          child: Divider(
                            thickness: 1,
                          )),
                      10.height,
                      Text(
                        'Your order has been sent ',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kNormalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'You will be notified when your order is confirmed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kNormalFontSize - 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                          context.read<OrderCubit>().emit(OrderInitial());
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GColors.whiteShade3.shade600),
                        ),
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Text(
                              'Go Back',
                              style: TextStyle(
                                color: GColors.royalBlue,
                                fontSize: kNormalFontSize,
                              ),
                            ),
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: GColors.royalBlue,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        if (state is OrderLoading) {
          return const GlobalLoadingBar(mainText: false);
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 100,
                      child: Divider(
                        thickness: 1,
                      )),
                  10.height,
                  Text(
                    'Confirm Your Booking  \$${(isRefundable ? (totalAmount * 1.05).toStringAsFixed(2) : totalAmount)}JOD',
                    style: const TextStyle(
                      fontSize: kNormalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.height,
                  VenueCreditCardForm(
                    isRefundable: isRefundable,
                    onRefundableChanged: onRefundableChanged,
                  ),
                  Text(
                    'Please note, on confirmation ${(isRefundable ? '%15' : '%10')} of the price will not be refunded.',
                    style: const TextStyle(fontSize: kSmallFontSize),
                  ),
                  10.height,
                  const Text(
                    'Are you sure you want to proceed with the booking?',
                    style: TextStyle(
                      fontSize: kSmallFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3,
                          ),
                        ),
                        icon: Text(
                          'Cancel',
                          style: TextStyle(
                            color: GColors.royalBlue,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async => await context
                            .read<OrderCubit>()
                            .createOrder(
                              EOrder(
                                id: Unique.generateUniqueId(),
                                eventType: eventType,
                                userId: userId,
                                eventId: venueId,
                                ownerId: ownerId,
                                amount: isRefundable
                                    ? double.parse(
                                        (totalAmount * 1.05).toStringAsFixed(2))
                                    : totalAmount,
                                startTime: startTime,
                                endTime: endTime,
                                people: people,
                                status: OrderStatus.pending,
                                createdAt: DateTime.now(),
                                date: date!,
                                isRefundable: isRefundable,
                              ),
                              meals,
                              drinks,
                            ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.whiteShade3.shade600,
                          ),
                        ),
                        icon: Text(
                          'Confirm',
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
      },
    );
  }
}
