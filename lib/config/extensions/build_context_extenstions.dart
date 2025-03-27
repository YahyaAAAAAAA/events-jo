import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/transition_animation.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void push(
    Widget child, {
    Duration? duration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
  }) {
    Navigator.of(this).push(
      PageRouteBuilder(
        transitionDuration: duration ?? const Duration(milliseconds: 300),
        reverseTransitionDuration:
            duration ?? const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: transitionBuilder ?? TransitionAnimations.fade,
      ),
    );
  }

  void replace(
    Widget child, {
    Duration? duration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
  }) {
    Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        transitionDuration: duration ?? const Duration(milliseconds: 500),
        reverseTransitionDuration:
            duration ?? const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: transitionBuilder ?? TransitionAnimations.fade,
      ),
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }

  // Show a basic SnackBar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            message,
            style: Theme.of(this).textTheme.labelMedium,
          ),
        ),
        backgroundColor: Theme.of(this).secondaryHeaderColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kOuterRadius),
            topRight: Radius.circular(kOuterRadius),
          ),
        ),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  //animated dialog
  Future<Object?> dialog({
    required Widget Function(BuildContext, Animation<double>, Animation<double>)
        pageBuilder,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    bool? barrierDismissible,
    Duration? transitionDuration,
  }) async {
    return showGeneralDialog(
      context: this,
      pageBuilder: pageBuilder,
      barrierLabel: '',
      barrierDismissible: barrierDismissible ?? true,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 200),
      transitionBuilder: transitionBuilder ?? TransitionAnimations.fade,
    );
  }
}
