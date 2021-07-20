import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

class SegmentCirclePainter extends CustomPainter {

  static const Color centerCircleColor = Colors.black;
  static const double centerCircleDiameter = 10;
  static const double circleRadianAmount = 2 * pi;
  final colors = Queue.from([Colors.red, Colors.green, Colors.yellow, Colors.pink, Colors.amber, Colors.teal, Colors.cyanAccent, Colors.blue, Colors.deepOrangeAccent, Colors.indigo]);




  final inputNumbers = [1,2, 3, 4, 5, 6, 7, 8,];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    Offset circleOffset = Offset(size.width / 2, size.width / 2);
    canvas.drawCircle(circleOffset, centerCircleDiameter, paint..color = centerCircleColor);
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final circleRadius = rect.width / 2;
    final step = circleRadianAmount/inputNumbers.length;
    var segmentStartPoint = -step/2;
    for (final each in inputNumbers) {
      final colorIndex = Random().nextInt(colors.length - 1);
      paint..color = colors.removeFirst();
      // print("segmentStartPoint = ${segmentStartPoint} step = $step colorIndex = $colorIndex");
      canvas.drawArc(rect, segmentStartPoint, step, true, paint);
      final textCircleRadius = circleRadius - circleRadius/5;
      final centerInCurrentSegmentRadian = segmentStartPoint + step/2;
      final textPointX = (textCircleRadius  * cos(centerInCurrentSegmentRadian)) + rect.width/2;
      final textPointY = (textCircleRadius  * sin(centerInCurrentSegmentRadian)) + rect.height/2;
      final textSpan = TextSpan(
        text: each.toString(),
        style: TextStyle(color: Colors.black, fontSize: 21)
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
      print("textPointX = $textPointX textPointY = $textPointY");
      segmentStartPoint+= step;
    }
    canvas.drawCircle(circleOffset, centerCircleDiameter, paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}