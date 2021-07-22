import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_bottle_view.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_view.dart';

class SegmentCircleBottleAnimatedView extends StatefulWidget {

  final SegmentCircleBottleAnimatedViewController segmentCircleController;

  const SegmentCircleBottleAnimatedView({Key? key, required this.segmentCircleController}) : super(key: key);

  @override
  _SegmentCircleBottleAnimatedViewState createState() =>
      _SegmentCircleBottleAnimatedViewState();
}

class _SegmentCircleBottleAnimatedViewState extends State<SegmentCircleBottleAnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double angle = pi*15;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 15), upperBound: angle);
    widget.segmentCircleController._init(angle, _controller, context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: SegmentBottleCircleWidget(widget.segmentCircleController.inputLabels),),
    Center(child:AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget? _widget) {
        print("value = ${_controller.value}");
        return new Transform.rotate(
          angle: _controller.value,
          child: Image(image: AssetImage("assets/images/wine-bottle.png"), height: MediaQuery.of(context).size.width/2,),
        );
      },)),
      // Align(alignment: Alignment.centerRight, child:Container(width:40, height: 40,child: Image(image:AssetImage("assets/images/arrow_left.ico")))),
    ],);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SegmentCircleBottleAnimatedViewController {

  late AnimationController _controller;
  late double _angle;
  late BuildContext _context;
  final inputLabels;
  double step = 0;
  double startPointAngle = 0;
  SegmentCircleBottleAnimatedViewController(this.inputLabels);

  void _init(double angle, AnimationController controller, BuildContext context){
    this._angle = angle;
    this._controller = controller;
    _context = context;
    step = (2*pi)/inputLabels.length;
    startPointAngle = -step/2;
  }

  void runAnimation({SpringDescription? springDescription}) {
    _angle = Random().nextDouble() * pi * 15;
    final spring = springDescription ?? SpringDescription(
      mass: 2,
      stiffness: 10,
      damping: 3,
    );

    final simulation =  SpringSimulation(spring, 0, _angle, -2);
    _controller.animateWith(simulation).whenCompleteOrCancel(() {
      var exactAngle = calculateValueFromAngle(_angle%(pi*2), inputLabels);
      final snackBar = SnackBar(content: Text('$exactAngle'));
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    });
  }

  String calculateValueFromAngle(double angle, List inputLabels) {
    double backAngle = angle + startPointAngle*2;
    double doubleIndex = backAngle / step;
    if (doubleIndex < 0) {
      doubleIndex = 2*pi + doubleIndex;
    }
    int index = doubleIndex.toInt();
    print("startPointAngle = ${startPointAngle} step = ${step} angle = $angle doubleIndex = $doubleIndex");
    print("index = $index");
    return inputLabels[index];
  }
}
