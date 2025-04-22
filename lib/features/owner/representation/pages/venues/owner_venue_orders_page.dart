import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/order/representation/components/user_order_card.dart';
import 'package:events_jo/features/order/representation/components/user_orders_empty.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venue_order_details_modal_sheet.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OwnerVenueOrdersPage extends StatefulWidget {
  final String venueId;
  final String venueName;

  const OwnerVenueOrdersPage({
    Key? key,
    required this.venueId,
    required this.venueName,
  }) : super(key: key);

  @override
  State<OwnerVenueOrdersPage> createState() => _OwnerVenueOrdersPageState();
}

class _OwnerVenueOrdersPageState extends State<OwnerVenueOrdersPage> {
  late final AppUser? user;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    context.read<OrderCubit>().getOrders('venueId', widget.venueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Manage Your Venue Orders',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocConsumer<OrderCubit, OrderStates>(
              listener: (context, state) {
                if (state is OrderError) {
                  context.showSnackBar('Something wrong happend.');
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    MediaQuery.of(context).size.width >= 156
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.venueName} Orders",
                                style: TextStyle(
                                  color: GColors.black,
                                  fontSize: kNormalFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async => await context
                                    .read<OrderCubit>()
                                    .getOrders('venueId', widget.venueId),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      GColors.scaffoldBg),
                                ),
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  color: GColors.black,
                                ),
                              )
                            ],
                          )
                        : 0.width,
                    Expanded(
                      child: Skeletonizer(
                        enabled: state is OrderLoading ? true : false,
                        containersColor: GColors.white,
                        child: state is UserOrdersLoaded
                            ? state.orders.isEmpty
                                ? UserOrdersEmpty(
                                    text: user!.name.toCapitalized)
                                : ListView.separated(
                                    itemCount: state.orders.length,
                                    separatorBuilder: (context, index) =>
                                        10.height,
                                    itemBuilder: (context, index) {
                                      final order = state.orders[index].order;
                                      final meals = state.orders[index].meals;
                                      final drinks = state.orders[index].drinks;

                                      return UserOrderCard(
                                        order: order,
                                        onPressed: () async {
                                          final venue = await context
                                              .read<WeddingVenuesCubit>()
                                              .getVenue(order.venueId);
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor:
                                                GColors.whiteShade3,
                                            showDragHandle: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(
                                                    kOuterRadius),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return OwnerVenueOrderDetailsModalSheet(
                                                venue: venue,
                                                order: order,
                                                meals: meals,
                                                drinks: drinks,
                                                onOrderConfirmPressed:
                                                    () async {
                                                  context.pop();
                                                  await context
                                                      .read<OrderCubit>()
                                                      .updateOrderStatus(
                                                        'venueId',
                                                        venue!.id,
                                                        order.id,
                                                        OrderStatus.completed,
                                                      );
                                                },
                                                onOrderCancelPressed: () async {
                                                  context.pop();
                                                  await context
                                                      .read<OrderCubit>()
                                                      .updateOrderStatus(
                                                        'venueId',
                                                        venue!.id,
                                                        order.id,
                                                        OrderStatus.canceled,
                                                      );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  )
                            : ListView.separated(
                                itemCount: 5,
                                separatorBuilder: (context, index) => 10.height,
                                itemBuilder: (context, index) =>
                                    const UserOrderCard()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Divider(
        color: GColors.poloBlue,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
