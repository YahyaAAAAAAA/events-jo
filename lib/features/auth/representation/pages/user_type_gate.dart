import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar_for_admins.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar_for_owners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTypeGate extends StatefulWidget {
  const UserTypeGate({super.key});

  @override
  State<UserTypeGate> createState() => _UserTypeGateState();
}

class _UserTypeGateState extends State<UserTypeGate> {
  late AppUser? currentUser;

  @override
  void initState() {
    super.initState();

    //get user
    currentUser = context.read<AuthCubit>().currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser!.type == UserType.admin) {
      return GlobalNavigationBarForAdmins(
        user: currentUser!,
      );
    }
    if (currentUser!.type == UserType.owner) {
      return GlobalNavigationBarForOwners(user: currentUser!);
    } else {
      return GlobalNavigationBar(user: currentUser!);
    }
  }
}
