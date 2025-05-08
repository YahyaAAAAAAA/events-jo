import 'package:flutter/material.dart';

enum Clickable {
  none,
  everywhere,
  firstChildOnly,
}

enum ArrowLocation {
  top,
  right,
  bottom,
  left,
}

enum Helper {
  none,
  text,
  arrow,
}

class Expandable extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;
  final Widget? subChild;
  final Function? onPressed;
  final Color backgroundColor;
  final Duration animationDuration;
  final DecorationImage? backgroundImage;
  final bool? showArrowWidget;
  final bool? initiallyExpanded;
  final bool centralizeFirstChild;
  final Widget? arrowWidget;
  final ArrowLocation? arrowLocation;
  final Function? onLongPress;
  final Animation<double>? animation;
  final AnimationController? animationController;
  final void Function(bool)? onHover;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final Clickable clickable;
  //--app specific--
  final bool isExpanded;

  const Expandable({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.isExpanded,
    this.subChild,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 400),
    this.backgroundImage,
    this.showArrowWidget,
    this.initiallyExpanded,
    this.centralizeFirstChild = true,
    this.arrowWidget,
    this.arrowLocation = ArrowLocation.right,
    this.borderRadius,
    this.clickable = Clickable.firstChildOnly,
    this.onLongPress,
    this.animation,
    this.animationController,
    this.onHover,
    this.boxShadow,
  });

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  final sizeTween = Tween<double>(begin: 0.0, end: 1.0);

  bool initiallyExpanded = false;

  @override
  void initState() {
    super.initState();
    initiallyExpanded = widget.initiallyExpanded ?? false;
    controller = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: widget.animationDuration,
        );

    animation = widget.animation ??
        sizeTween.animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
          ),
        );
  }

  @override
  void dispose() {
    if (widget.animationController != null) {
      controller.dispose();
    }
    super.dispose();
  }

  void toggleExpand() {
    if (initiallyExpanded == true) initiallyExpanded = false;
    switch (animation.status) {
      case AnimationStatus.completed:
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  Future<void> onPressed() async {
    if (widget.onPressed != null && !controller.isAnimating) {
      await widget.onPressed!();
    }
    toggleExpand();
  }

  Future<void> onLongPress() async {
    if (widget.onLongPress != null && !controller.isAnimating) {
      await widget.onLongPress!();
    }
  }

  void onHover(bool isHovered) {
    if (widget.onHover != null) widget.onHover!(isHovered);

    if (isHovered) {
      toggleExpand();
    } else if (!isHovered) {
      if (initiallyExpanded != true) controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    //shrink if sidebar not expanded
    if (widget.isExpanded == false &&
        animation.status == AnimationStatus.completed) {
      toggleExpand();
    }
    if (initiallyExpanded == true) toggleExpand();
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        image: widget.backgroundImage,
        boxShadow: widget.boxShadow,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
      ),
      child: buildVerticalExpandable(),
    );
  }

  RotationTransition buildRotation() {
    return RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(animation),
      child: widget.arrowWidget ??
          const Icon(
            Icons.keyboard_arrow_up_rounded,
          ),
    );
  }

  Column buildVerticalExpandable() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.onHover != null ? onHover : null,
          onTap: widget.clickable != Clickable.none ? onPressed : null,
          onLongPress: widget.clickable != Clickable.none ? onLongPress : null,
          child: widget.showArrowWidget ?? true == true
              ? buildBodyWithArrow()
              : widget.subChild != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [widget.firstChild],
                        ),
                        widget.subChild!,
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [widget.firstChild],
                    ),
        ),
        buildInkWellContainer(buildSecondChild()),
      ],
    );
  }

  Widget buildBodyWithArrow() {
    return widget.subChild != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.firstChild,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: widget.arrowLocation == ArrowLocation.right
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  if (widget.centralizeFirstChild)
                    Visibility(visible: false, child: buildRotation()),
                  widget.subChild!,
                  buildRotation(),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: widget.arrowLocation == ArrowLocation.right
                ? TextDirection.ltr
                : TextDirection.rtl,
            children: [
              if (widget.centralizeFirstChild)
                Visibility(visible: false, child: buildRotation()),
              widget.firstChild,
              buildRotation(),
            ],
          );
  }

  SizeTransition buildSecondChild() {
    return SizeTransition(
      axisAlignment: 1,
      axis: Axis.vertical,
      sizeFactor: animation,
      child: widget.secondChild,
    );
  }

  InkWell buildInkWellContainer(Widget child) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHover: widget.onHover != null ? onHover : null,
      onTap: widget.clickable == Clickable.everywhere ? onPressed : null,
      onLongPress:
          widget.clickable == Clickable.everywhere ? onLongPress : null,
      child: child,
    );
  }
}
