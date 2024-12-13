import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final Gradient gradient;
  final double size;
  final Offset? offset;

  const GradientIcon({
    required this.icon,
    required this.gradient,
    this.size = 25,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //wrap the CustomPaint with RepaintBoundary to optimize repaint behavior
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(size, size),
        painter: _GradientIconPainter(
            icon: icon, gradient: gradient, iconSize: size, offsets: offset),
      ),
    );
  }
}

class _GradientIconPainter extends CustomPainter {
  final IconData? icon;
  final Gradient? gradient;
  final double? iconSize;
  final Offset? offsets;

  _GradientIconPainter({
    Listenable? repaint,
    required this.icon,
    required this.gradient,
    required this.iconSize,
    this.offsets,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    //create a Paint object to apply the gradient shader
    final Paint gradientShaderPaint = Paint();
    gradientShaderPaint.shader = gradient!
        .createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    //create a TextPainter to render the icon character with the gradient shader
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        //convert the icon code point to a string
        text: String.fromCharCode(
          icon!.codePoint,
        ),
        style: TextStyle(
          foreground: gradientShaderPaint,
          fontFamily: icon!.fontFamily,
          fontSize: iconSize,
        ),
      ),
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    //calculate the center position to horizontally and vertically align the icon
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;

    //create an offset for the icon's position within the canvas
    final offset = offsets ?? Offset(xCenter, yCenter + 8);

    //paint the icon on the canvas at the specified offset
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_GradientIconPainter oldDelegate) {
    //determine whether the painter should repaint based on changes in properties
    return icon != oldDelegate.icon ||
        gradient != oldDelegate.gradient ||
        iconSize != oldDelegate.iconSize;
  }
}
