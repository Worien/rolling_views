import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

class SegmentBottleCirclePainter extends CustomPainter {

  static const Color centerCircleColor = Colors.black12;
  static const double centerCircleDiameter = 10;
  static const double circleRadianAmount = 2 * pi;
  var colors = [ Colors.green, Colors.yellow, Colors.deepPurple, Colors.pink, Colors.amber, Colors.teal, Colors.cyanAccent, Colors.blue, Colors.deepOrangeAccent, Colors.indigo];

  final inputLabels;

  SegmentBottleCirclePainter(this.inputLabels);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    Offset circleOffset = Offset(size.width / 2, size.width / 2);
    canvas.drawCircle(circleOffset, size.width/2 + 10, paint..color = centerCircleColor);
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final circleRadius = rect.width / 2;
    final step = circleRadianAmount/inputLabels.length;
    var segmentStartPoint = -step/2;
    var index = 0;
    for (final label in inputLabels) {
      paint..color = colors[index%colors.length];
      index ++;
      canvas.drawArc(rect, segmentStartPoint, step, true, paint);
      final textCircleRadius = circleRadius - circleRadius/5;
      final centerInCurrentSegmentRadian = segmentStartPoint + step/2;
      drawLabel(textCircleRadius, centerInCurrentSegmentRadian, rect, label, size, canvas);
      segmentStartPoint+= step;
    }
    canvas.drawCircle(circleOffset, centerCircleDiameter, paint..color = Colors.white);
  }

  void drawLabel(double textCircleRadius, double centerInCurrentSegmentRadian, Rect rect, String label, Size size, Canvas canvas) {
    final textPointX = (textCircleRadius  * cos(centerInCurrentSegmentRadian)) + rect.width/2 - 8;
    final textPointY = (textCircleRadius  * sin(centerInCurrentSegmentRadian)) + rect.width/2 - 8;
    final textSpan = TextSpan(
        text: label,
        style: TextStyle(color: Colors.white, fontSize: 21)
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(textPointX, textPointY);
    canvas.save();
    final pivot = textPainter.size.center(offset);
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(centerInCurrentSegmentRadian);
    canvas.translate(-pivot.dx, -pivot.dy);
    textPainter.paint(canvas, offset);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}