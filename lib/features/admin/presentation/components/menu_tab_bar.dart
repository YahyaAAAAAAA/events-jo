import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/tab_item.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_states.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuTabBar extends StatelessWidget {
  final TabController controller;
  const MenuTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: GColors.white,
        ),
        child: TabBar(
          controller: controller,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: GColors.cyanShade6,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: GColors.cyanShade6,
          tabs: [
            BlocBuilder<AdminUnapproveCubit, AdminUnapproveStates>(
              builder: (context, state) {
                if (state is AdminUnapproveLoaded) {
                  return TabItem(
                    title: 'Unapproved',
                    count: state.venues.length,
                  );
                }
                //return normal tab if not loaded
                else {
                  return const TabItem(
                    title: 'Unapproved',
                    count: 0,
                  );
                }
              },
            ),
            BlocBuilder<AdminApproveCubit, AdminApproveStates>(
                builder: (context, state) {
              if (state is AdminApproveLoaded) {
                return TabItem(
                  title: 'Approved',
                  count: state.venues.length,
                );
              }
              //return normal tab if not loaded
              else {
                return const TabItem(
                  title: 'Approved',
                  count: 0,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
