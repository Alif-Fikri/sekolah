import 'package:flutter/material.dart';
import 'package:sekolah/common/colors.dart';

class CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 1.45);
    path.cubicTo(
      size.width,
      size.height * 0.95,
      size.width * 0.9,
      size.height * 1.09,
      size.width * 0.55,
      size.height * 1,
    );
    path.cubicTo(
      size.width,
      size.height,
      size.width,
      size.height,
      size.width,
      size.height,
    );
    path.quadraticBezierTo(
      size.width * -0.2,
      size.height * 1.3,
      0,
      size.height * 0.5,
    );
    path.lineTo(0, 0);
    path.close();

    canvas.drawShadow(path, Colors.black.withValues(), 9.0, true);

    final paint =
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.main, AppColors.main],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
