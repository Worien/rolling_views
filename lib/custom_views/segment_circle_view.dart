import 'package:flutter/material.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_painter.dart';

class SegmentCircleWidget extends StatelessWidget {

  final inputNumbers;

  const SegmentCircleWidget(this.inputNumbers);


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          painter: SegmentCirclePainter(inputNumbers),
          size: Size(screenWidth - 40, screenWidth - 40),
        ),
      ),
    );
  }
}