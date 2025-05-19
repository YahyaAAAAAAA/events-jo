import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_home_card.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_courts.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_venues.dart';
import 'package:events_jo/features/admin/presentation/pages/problem_report/problems_page.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPageForEvents extends StatefulWidget {
  const AdminPageForEvents({super.key});

  @override
  State<AdminPageForEvents> createState() => _AdminPageForEventsState();
}

class _AdminPageForEventsState extends State<AdminPageForEvents> {
  //user
  late final AppUser? user;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;
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
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kListViewWidth),
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Text(
                  'Monitor, Approve, Suspend and Deny Events',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kNormalFontSize,
                  ),
                ),
                20.height,
                AdminHomeCard(
                  text: 'Wedding Venues',
                  icon: CustomIcons.wedding,
                  onPressed: () => context.push(const AdminPageForVenues()),
                ),
                10.height,
                AdminHomeCard(
                  text: 'Football Courts',
                  icon: CustomIcons.football,
                  onPressed: () => context.push(const AdminPageForCourts()),
                ),
                10.height,
                AdminHomeCard(
                  text: 'Problems Reports',
                  icon: Icons.report_problem_rounded,
                  onPressed: () => context.push(const ProblemsPage()),
                ),
              ],
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
