import 'package:flutter/material.dart';

class AdminTabItem extends StatelessWidget {
  final String title;

  const AdminTabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
