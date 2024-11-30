import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminPageForFarms extends StatefulWidget {
  const AdminPageForFarms({super.key});

  @override
  State<AdminPageForFarms> createState() => _AdminPageForFarmsState();
}

class _AdminPageForFarmsState extends State<AdminPageForFarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Farms')),
      bottomNavigationBar: Divider(
        color: GColors.cyanShade6,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
