import 'package:flutter/material.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_bottle_painter.dart';

class SegmentBottleCircleWidget extends StatelessWidget {

  final inputLabels;

  const SegmentBottleCircleWidget(this.inputLabels);


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          painter: SegmentBottleCirclePainter(inputLabels),
          size: Size(screenWidth - 40, screenWidth - 40),
        ),
      ),
    );
  }
}