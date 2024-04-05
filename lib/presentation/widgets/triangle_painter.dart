
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final bool flipVertical;
  final bool flipHorizontal;
  final Color color;
  TrianglePainter({required this.color,required this.flipVertical, required this.flipHorizontal});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Цвет треугольника
      ..style = PaintingStyle.fill;

    final path = Path();

    if (!flipHorizontal && !flipVertical) {
      path.moveTo(0, size.height); // Начальная точка треугольника
      path.lineTo(size.width, size.height); // Вторая точка треугольника
      path.lineTo(size.width, 0); // Третья точка треугольника
    } else if (flipHorizontal && !flipVertical) {
      path.moveTo(size.width, size.height); // Начальная точка треугольника
      path.lineTo(0, size.height); // Вторая точка треугольника
      path.lineTo(0, 0); // Третья точка треугольника
    } else if (!flipHorizontal && flipVertical) {
      path.moveTo(0, 0); // Начальная точка треугольника
      path.lineTo(size.width, 0); // Вторая точка треугольника
      path.lineTo(size.width, size.height); // Третья точка треугольника
    } else {
      path.moveTo(size.width, 0); // Начальная точка треугольника
      path.lineTo(0, 0); // Вторая точка треугольника
      path.lineTo(0, size.height); // Третья точка треугольника
    }

    path.close(); // Закрыть путь, соединив начальную и конечную точку

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
