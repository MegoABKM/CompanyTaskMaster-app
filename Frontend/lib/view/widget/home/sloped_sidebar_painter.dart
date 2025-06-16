import 'package:flutter/material.dart';

class SlopedSidebarPainter extends CustomPainter {
  final BuildContext context;
  final bool isArabic;

  SlopedSidebarPainter(this.context, {required this.isArabic});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    if (isArabic) {
      // RTL (Arabic): Slope from left to right
      path.moveTo(0, 0); // Top-left
      path.lineTo(size.width, size.height * 0.1); // Slope to top-right
      path.lineTo(size.width, size.height * 0.9); // Down to bottom-right
      path.lineTo(0, size.height); // Bottom-left
    } else {
      // LTR (English): Slope from right to left
      path.moveTo(size.width, 0); // Top-right
      path.lineTo(0, size.height * 0.1); // Slope to top-left
      path.lineTo(0, size.height * 0.9); // Down to bottom-left
      path.lineTo(size.width, size.height); // Bottom-right
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless language or size changes
  }
}
