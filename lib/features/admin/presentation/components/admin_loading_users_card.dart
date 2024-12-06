import 'package:events_jo/features/admin/presentation/components/admin_users_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminLoadingUsersCard extends StatelessWidget {
  const AdminLoadingUsersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => AdminUsersCard(
          name: 'name',
          index: index,
          isOnline: true,
          isLoading: true,
          onPressed: null,
        ),
      ),
    );
  }
}
