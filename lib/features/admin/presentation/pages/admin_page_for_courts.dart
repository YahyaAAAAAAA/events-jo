import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminPageForCourts extends StatefulWidget {
  const AdminPageForCourts({super.key});

  @override
  State<AdminPageForCourts> createState() => _AdminPageForCourtsState();
}

class _AdminPageForCourtsState extends State<AdminPageForCourts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Football Courts')),
      bottomNavigationBar: Divider(
        color: GColors.cyanShade6,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
