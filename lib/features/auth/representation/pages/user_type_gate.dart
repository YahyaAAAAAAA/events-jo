import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar_for_admins.dart';
import 'package:events_jo/features/navigation/presentation/global_navigation_bar_for_owners.dart';
import 'package:flutter/material.dart';

class UserTypeGate extends StatefulWidget {
  const UserTypeGate({super.key});

  @override
  State<UserTypeGate> createState() => _UserTypeGateState();
}

class _UserTypeGateState extends State<UserTypeGate> {
  late AppUser? user;

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (user!.type == UserType.admin) {
      return const GlobalNavigationBarForAdmins();
    }
    if (user!.type == UserType.owner) {
      return const GlobalNavigationBarForOwners();
    } else {
      return const GlobalNavigationBar();
    }
  }
}
