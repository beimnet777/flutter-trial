import 'package:flutter/material.dart';

class GradientBackgroundPainter extends CustomPainter {
  final Alignment alignment;

  GradientBackgroundPainter({Key? key, required this.alignment});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw bottom-left gradient

    // Draw top-right gradient
    paint.shader = RadialGradient(
      center: alignment,
      radius: 0.5, // Spread size of the gradient
      colors: [
        Color.fromARGB(255, 96, 169, 222), // Light Blue from corners
        Color(0xFFFFFFFF), // White at the center
      ],
      stops: [0.0, 1.0], // Control the spread between colors
      tileMode: TileMode.clamp,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
