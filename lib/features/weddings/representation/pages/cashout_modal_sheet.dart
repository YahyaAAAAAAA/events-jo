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
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_credit_card_card.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashoutModalSheet extends StatelessWidget {
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

  const CashoutModalSheet({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
    required this.userId,
    required this.ownerId,
    required this.venueId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.people,
    this.meals,
    this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    //todo
    String localPaymentMethod = paymentMethod;
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
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.whiteShade3.shade600),
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
            ),
          );
        }
        if (state is OrderLoading) {
          return const GlobalLoadingBar(mainText: false);
        } else {
          return StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Confirm Your Booking',
                        style: TextStyle(
                          fontSize: kNormalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      VenuePaymentCard(
                        onPressed: () => setState(
                          () => localPaymentMethod = 'credit',
                        ),
                        title: 'Credit Card',
                        value: 'credit',
                        groupValue: localPaymentMethod,
                        icon: Icons.add_circle_outline_rounded,
                      ),
                      10.height,
                      AnimatedCrossFade(
                        crossFadeState: localPaymentMethod == 'credit'
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                        firstChild: 0.height,
                        secondChild: VenueCreditCardForm(),
                      ),
                      10.height,
                      VenuePaymentCard(
                        onPressed: () => setState(
                          () => localPaymentMethod = 'cash',
                        ),
                        title: 'Cash',
                        value: 'cash',
                        groupValue: localPaymentMethod,
                        icon: Icons.attach_money_rounded,
                      ),
                      10.height,
                      const Text(
                        'Are you sure you want to proceed with the booking?',
                        style: TextStyle(fontSize: kSmallFontSize),
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
                            onPressed: () async =>
                                await context.read<OrderCubit>().createOrder(
                                      EOrder(
                                        id: Unique.generateUniqueId(),
                                        userId: userId,
                                        venueId: venueId,
                                        ownerId: ownerId,
                                        amount: totalAmount,
                                        startTime: startTime,
                                        endTime: endTime,
                                        people: people,
                                        status: OrderStatus.pending,
                                        createdAt: DateTime.now(),
                                        date: date!,
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
            },
          );
        }
      },
    );
  }
}
