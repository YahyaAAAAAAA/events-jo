import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/chat/representation/pages/chats_page.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/order/representation/components/order_details_modal_sheet.dart';
import 'package:events_jo/features/order/representation/components/user_order_card.dart';
import 'package:events_jo/features/order/representation/components/user_orders_empty.dart';
import 'package:events_jo/features/order/representation/cubits/order_cubit.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersPage extends StatefulWidget {
  final UserType userType;

  const OrdersPage({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late final OrderCubit orderCubit;
  late final AppUser? user;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    orderCubit = context.read<OrderCubit>();
    if (orderCubit.cachedOrders == null) {
      orderCubit.getOrders('userId', user!.uid, cache: true);
    } else if (orderCubit.cachedUserId != user?.uid) {
      orderCubit.getOrders('userId', user!.uid, cache: true);
    } else {
      orderCubit.getCachedOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: widget.userType == UserType.owner ? true : false,
        title: user!.name,
        onOwnerButtonTap: () => context.push(OwnerMainPage(user: user)),
        onChatsPressed: () => context.push(ChatsPage(user: user!)),
        onPressed: () =>
            context.read<AuthCubit>().logout(user!.uid, user!.type),
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
                                "Your Bookings",
                                style: TextStyle(
                                  color: GColors.black,
                                  fontSize: kNormalFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async =>
                                    await orderCubit.getOrders(
                                  'userId',
                                  user!.uid,
                                  cache: true,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        GColors.scaffoldBg)),
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
                                          var event;
                                          if (order.eventType ==
                                              EventType.venue) {
                                            event = await context
                                                .read<WeddingVenuesCubit>()
                                                .getVenue(order.eventId);
                                            if (event == null) {
                                              context.showSnackBar(
                                                  'Venue doesn\'t exist');
                                              return;
                                            }
                                          }
                                          if (order.eventType ==
                                              EventType.court) {
                                            event = await context
                                                .read<FootballCourtsCubit>()
                                                .getCourt(order.eventId);
                                            if (event == null) {
                                              context.showSnackBar(
                                                  'Court doesn\'t exist');
                                              return;
                                            }
                                          }
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
                                              return OrderDetailsModalSheet(
                                                user: user!,
                                                venue: event,
                                                order: order,
                                                meals: meals,
                                                drinks: drinks,
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
        height: 0,
      ),
    );
  }
}
