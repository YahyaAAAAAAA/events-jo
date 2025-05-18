import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/expandable.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_divider.dart';
import 'package:events_jo/features/admin/presentation/components/admin_order_card.dart';
import 'package:events_jo/features/admin/presentation/cubits/order/admin_order_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/order/admin_order_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminPageForOrders extends StatefulWidget {
  const AdminPageForOrders({super.key});

  @override
  State<AdminPageForOrders> createState() => _AdminPageForOrdersState();
}

class _AdminPageForOrdersState extends State<AdminPageForOrders> {
  //user
  late final AppUser? user;

  late final AdminOrderCubit adminOrderCubit;

  List<bool> isExpanded = [
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    adminOrderCubit = context.read<AdminOrderCubit>();

    adminOrderCubit.getOrdersStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: false,
        title: user?.name ?? 'Guest 123',
        onPressed: () =>
            context.read<AuthCubit>().logout(user!.uid, user!.type),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: BlocConsumer<AdminOrderCubit, AdminOrderStates>(
            listener: (context, state) {
              if (state is AdminOrderError) {
                context.showSnackBar(state.message);
              }
              if (state is AdminOrderActionLoading) {
                context.showSnackBar(state.message);
              }

              if (state is AdminOrderActionLoaded) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              if (state is AdminOrderLoaded) {
                final detaildOrders = state.orders;

                final Map<String, List<EOrder>> groupedOrders = {
                  'unpaid': [],
                  'paid': [],
                  'pending': [],
                  'completed': [],
                  'cancelled': [],
                  'refunded': [],
                };

                for (var order in detaildOrders) {
                  final status = order.status.name.toLowerCase();
                  if (groupedOrders.containsKey(status)) {
                    groupedOrders[status]!.add(order);
                  }
                }
                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    Text(
                      'Monitor, Refund and Transfer Bookings',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                      ),
                    ),
                    20.height,

                    //held bookings on the app side
                    const AdminDivider(text: 'Held bookings on the app side'),

                    5.height,

                    _buildExpandable(
                      isExpanded: isExpanded[3],
                      status: OrderStatus.completed,
                      orders: groupedOrders['completed']!,
                    ),
                    10.height,
                    _buildExpandable(
                      isExpanded: isExpanded[4],
                      status: OrderStatus.cancelled,
                      orders: groupedOrders['cancelled']!,
                    ),

                    10.height,

                    //held bookings on the owner/user side
                    const AdminDivider(
                        text: 'Held bookings on the owner/user side'),

                    5.height,

                    _buildExpandable(
                      isExpanded: isExpanded[2],
                      status: OrderStatus.pending,
                      orders: groupedOrders['pending']!,
                    ),

                    10.height,

                    //processed bookings
                    const AdminDivider(text: 'Processed bookings'),

                    5.height,

                    _buildExpandable(
                      isExpanded: isExpanded[0],
                      status: OrderStatus.unpaid,
                      orders: groupedOrders['unpaid']!,
                    ),
                    10.height,
                    _buildExpandable(
                      isExpanded: isExpanded[1],
                      status: OrderStatus.paid,
                      orders: groupedOrders['paid']!,
                    ),
                    10.height,
                    _buildExpandable(
                      isExpanded: isExpanded[1],
                      status: OrderStatus.refunded,
                      orders: groupedOrders['refunded']!,
                    ),
                  ],
                );
              } else {
                return _buildLoading();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Divider(
        color: GColors.poloBlue,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
        height: 0,
      ),
    );
  }

  Skeletonizer _buildLoading() {
    return Skeletonizer(
      enabled: true,
      containersColor: GColors.white,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            'Monitor, Refund and Transfer Bookings',
            style: TextStyle(
              color: GColors.black,
              fontSize: kNormalFontSize,
            ),
          ),
          20.height,
          _buildExpandable(
              isExpanded: false, status: OrderStatus.cancelled, orders: []),
          10.height,
          _buildExpandable(
              isExpanded: false, status: OrderStatus.cancelled, orders: []),
          10.height,
          _buildExpandable(
              isExpanded: false, status: OrderStatus.cancelled, orders: []),
          10.height,
          _buildExpandable(
              isExpanded: false, status: OrderStatus.cancelled, orders: []),
          10.height,
          _buildExpandable(
              isExpanded: false, status: OrderStatus.cancelled, orders: []),
        ],
      ),
    );
  }

  Widget _buildExpandable({
    required bool isExpanded,
    required OrderStatus status,
    required List<EOrder> orders,
  }) {
    return Expandable(
      isExpanded: isExpanded,
      onPressed: () => setState(() => isExpanded != isExpanded),
      borderRadius: BorderRadius.circular(kOuterRadius),
      firstChild: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: null,
                padding: const EdgeInsets.all(12),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                  ),
                ),
                icon: Text(
                  orders.length.toString(),
                  style: TextStyle(
                    color: GColors.cyanShade6,
                    fontSize: kSmallFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${status.name.toCapitalized} Bookings',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
      arrowWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                GColors.cyanShade6,
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_up_rounded,
              color: GColors.white,
            )),
      ),
      secondChild: Column(
        children: orders
            .map(
              (order) => AdminOrderCard(
                subText: order.status == OrderStatus.cancelled
                    ? order.canceledBy
                    : null,
                onPressed: order.status == OrderStatus.unpaid ||
                        order.status == OrderStatus.paid ||
                        order.status == OrderStatus.pending ||
                        order.status == OrderStatus.refunded
                    ? null
                    //transfer
                    : order.status == OrderStatus.completed
                        ? () async {
                            await adminOrderCubit.transfer(
                              stripeAccountId: order.stripeAccountId,
                              orderId: order.id,
                              amount: order.amount,
                            );
                          }
                        //refund
                        : order.status == OrderStatus.cancelled
                            ? () async {
                                await adminOrderCubit.refund(
                                  paymentIntentId: order.paymentIntentId,
                                  orderId: order.id,
                                  cancelledBy: order.canceledBy ?? 'owner',
                                  amount: order.amount,
                                );
                              }
                            : null,
                order: order,
              ),
            )
            .toList(),
      ),
    );
  }
}
