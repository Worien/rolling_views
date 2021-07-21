import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_view.dart';

class SegmentCircleAnimatedView extends StatefulWidget {

  final SegmentCircleAnimatedViewController segmentCircleController;

  const SegmentCircleAnimatedView({Key? key, required this.segmentCircleController}) : super(key: key);

  @override
  _SegmentCircleAnimatedViewState createState() =>
      _SegmentCircleAnimatedViewState();
}

class _SegmentCircleAnimatedViewState extends State<SegmentCircleAnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double angle = pi*15;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 15), upperBound: angle);
    widget.segmentCircleController._init(angle, _controller, context);
    // widget.segmentCircleController.runAnimation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget? _widget) {
        print("value = ${_controller.value}");
        return new Transform.rotate(
          angle: _controller.value,
          child: SegmentCircleWidget(widget.segmentCircleController.inputNumbers),
        );
      },),
      Align(alignment: Alignment.centerRight, child:Container(width:40, height: 40,child: Image(image:AssetImage("assets/images/arrow_left.ico")))),
    ],);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SegmentCircleAnimatedViewController {

  late AnimationController _controller;
  late double _angle;
  late BuildContext _context;
  final inputNumbers;
  double step = 0;
  double startPointAngle = 0;
  SegmentCircleAnimatedViewController(this.inputNumbers);

  void _init(double angle, AnimationController controller, BuildContext context){
    this._angle = angle;
    this._controller = controller;
    _context = context;
    step = (2*pi)/inputNumbers.length;
    startPointAngle = -step/2;
  }

  void runAnimation() {
    _angle = Random().nextDouble() * pi * 15;
    const spring = SpringDescription(
      mass: 2,
      stiffness: 10,
      damping: 3,
    );

    final simulation = SpringSimulation(spring, 0, _angle, -2);
    _controller.animateWith(simulation).whenCompleteOrCancel(() {
      var exactAngle = calculateValueFromAngle(_angle%(pi*2), inputNumbers);
      final snackBar = SnackBar(content: Text('$exactAngle'));
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    });
  }

  int calculateValueFromAngle(double angle, List inputNumbers) {
    double indexDouble = angle / step;
    double some = (2*pi) - angle - startPointAngle;
    int index = some ~/ step;
    return inputNumbers[index];
  }
}
