import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  final int itemCount;
  final int currentIndex;
  final double indicatorWidth;
  final double indicatorSpacing;
  final double indicatorHeight;
  final Color indicatorColor;
  final Color currentIndicatorColor;
  final double strokeWidth;
  final Color strokeColor;

  IndicatorPainter({
    required this.itemCount,
    required this.currentIndex,
    this.indicatorWidth = 10,
    this.indicatorHeight = 5,
    this.indicatorSpacing = 5,
    this.indicatorColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.currentIndicatorColor = Colors.white,
    this.strokeWidth = 1,
    this.strokeColor =  const Color.fromRGBO(165, 165, 165, 1.0),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double totalWidth =
        (indicatorWidth * itemCount) + (indicatorSpacing * (itemCount - 1));
    final double startX = (size.width - totalWidth) / 2;

    for (int i = 0; i < itemCount; i++) {
      final double x = startX + (indicatorWidth + indicatorSpacing) * i;
      final Color color =
      i == currentIndex ? currentIndicatorColor : indicatorColor;
      final Rect rect = Rect.fromLTWH(x, 0, indicatorWidth, indicatorHeight);
      final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      final Paint paint = Paint()..color = color;
      final Paint strokePaint = Paint()
        ..color = strokeColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(rRect, strokePaint);
      canvas.drawRRect(rRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
