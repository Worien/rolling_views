import 'package:flutter/material.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_painter.dart';

class SegmentCircleWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          painter: SegmentCirclePainter(),
          size: Size(screenWidth - 10, screenWidth - 10),
        ),
      ),
    );
  }
}