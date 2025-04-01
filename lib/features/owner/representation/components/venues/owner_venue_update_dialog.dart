import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class OwnerVenueUpdateDialog extends StatelessWidget {
  final Widget? child;
  final String? title;
  final bool? hideActions;
  final List<Widget>? actions;
  final void Function()? onDonePressed;
  final void Function()? onCancelPressed;

  const OwnerVenueUpdateDialog({
    super.key,
    this.child,
    this.title,
    this.hideActions = false,
    this.actions,
    this.onDonePressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: child,
      title: Text(
        title ?? 'Update venue',
        style: TextStyle(
          color: GColors.black,
          fontSize: kNormalFontSize - 3,
          fontWeight: FontWeight.bold,
          fontFamily: 'Abel',
        ),
      ),
      actions: hideActions != null && hideActions! ? null : buildActions(),
    );
  }

  List<Widget> buildActions() {
    return [
      IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.whiteShade3),
        ),
        onPressed: onCancelPressed,
        icon: Text(
          'Cancel',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: kSmallFontSize,
          ),
        ),
      ),
      IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.whiteShade3.shade600),
        ),
        onPressed: onDonePressed,
        icon: Text(
          'Done',
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: kSmallFontSize,
          ),
        ),
      ),
    ]..insertAll(0, actions ?? []);
  }
}
