import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final AppUser? user;

  @override
  void initState() {
    super.initState();

    user = context.read<AuthCubit>().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onPressed: () => context.read<AuthCubit>().logout(
              user!.uid,
              user!.type,
            ),
      ),
    );
  }
}
