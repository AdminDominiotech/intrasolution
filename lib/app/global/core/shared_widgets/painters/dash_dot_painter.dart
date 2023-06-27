// Flutter imports:
import 'package:flutter/material.dart';

//Autor: https://github.com/br-programmer
class DashDotPainter extends CustomPainter {
  const DashDotPainter({
    this.strokeWidth = 2,
    this.color = Colors.green,
    this.radius = const Radius.circular(10),
    this.strokeCap = StrokeCap.butt,
    this.dottedLength = 15,
    this.space = 10,
  });
  final double strokeWidth;
  final Color color;
  final Radius radius;
  final StrokeCap strokeCap;
  final double dottedLength;
  final double space;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          radius,
        ),
      );
    final draw = Path();
    for (final metric in path.computeMetrics()) {
      var start = 0.0;
      while (start < metric.length) {
        var end = start + dottedLength;
        draw.addPath(metric.extractPath(start, end), Offset.zero);
        start = end + space;
      }
    }
    canvas.drawPath(draw, paint);
  }

  @override
  bool shouldRepaint(DashDotPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dottedLength != dottedLength ||
      oldDelegate.radius != radius ||
      oldDelegate.space != space ||
      oldDelegate.strokeCap != strokeCap ||
      oldDelegate.strokeWidth != strokeWidth;
}
