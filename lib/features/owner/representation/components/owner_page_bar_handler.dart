import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
import 'package:flutter/material.dart';

//* this page hides the top logo in OwnerPage if a certain height is exceeded
class OwnerPageBarHandler extends StatelessWidget {
  final int index;
  final bool isImagesEmpty;

  const OwnerPageBarHandler({
    super.key,
    required this.index,
    required this.isImagesEmpty,
  });

  @override
  Widget build(BuildContext context) {
    //go through each page
    if (MediaQuery.of(context).size.height > 547 && index == 0) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 547 && index == 1) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 547 && index == 2) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 547 &&
        index == 3 &&
        isImagesEmpty) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 792 &&
        index == 3 &&
        (isImagesEmpty == false)) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 722 && index == 4) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 629 && index == 5) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 603 && index == 6) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 500 && index == 7) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 500 && index == 8) {
      return const OwnerPageBar();
    } else if (MediaQuery.of(context).size.height > 500 && index == 9) {
      return const OwnerPageBar();
    } else {
      return const SizedBox();
    }
  }
}
