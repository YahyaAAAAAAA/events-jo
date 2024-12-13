import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppUser? user;
  final PreferredSize? bottom;

  const AdminAppBar({
    super.key,
    required this.user,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          onPressed: () =>
              context.read<AuthCubit>().logout(user!.uid, user!.type),
          icon: Icons.person,
          size: 25,
        ),
        bottom: bottom,
        actions: [
          AppBarButton(
            onPressed: () {},
            icon: CustomIcons.menu,
            size: 20,
          ),
        ],
        leadingWidth: 90,
        toolbarHeight: 70,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
