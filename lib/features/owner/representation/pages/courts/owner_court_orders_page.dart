import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/order/representation/components/user_order_card.dart';
import 'package:events_jo/features/order/representation/components/user_orders_empty.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/owner/representation/pages/courts/owner_court_order_details_modal_sheet.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OwnerCourtOrdersPage extends StatefulWidget {
  final String courtId;
  final String courtName;

  const OwnerCourtOrdersPage({
    Key? key,
    required this.courtId,
    required this.courtName,
  }) : super(key: key);

  @override
  State<OwnerCourtOrdersPage> createState() => _OwnerCourtOrdersPageState();
}

class _OwnerCourtOrdersPageState extends State<OwnerCourtOrdersPage> {
  late final AppUser? user;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    context.read<OrderCubit>().getOrders('eventId', widget.courtId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Manage Your Court Orders',
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
                                "${widget.courtName} Orders",
                                style: TextStyle(
                                  color: GColors.black,
                                  fontSize: kNormalFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async => await context
                                    .read<OrderCubit>()
                                    .getOrders('eventId', widget.courtId),
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

                                      return UserOrderCard(
                                        order: order,
                                        onPressed: () async {
                                          final court = await context
                                              .read<FootballCourtsCubit>()
                                              .getCourt(order.eventId);
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
                                              return OwnerCourtOrderDetailsModalSheet(
                                                user: user!,
                                                court: court!,
                                                order: order,
                                                onOrderConfirmPressed:
                                                    () async {
                                                  context.pop();
                                                  await context
                                                      .read<OrderCubit>()
                                                      .updateOrderStatus(
                                                        'eventId',
                                                        court.id,
                                                        order.id,
                                                        OrderStatus.completed,
                                                      );
                                                },
                                                onOrderCancelPressed: () async {
                                                  context.pop();
                                                  await context
                                                      .read<OrderCubit>()
                                                      .updateOrderStatus(
                                                        'eventId',
                                                        court.id,
                                                        order.id,
                                                        OrderStatus.cancelled,
                                                        canceledBy: 'owner',
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
