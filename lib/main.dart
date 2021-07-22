import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_animated_view.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_bottle_animated_view.dart';
import 'package:flutter_circle_views/custom_views/segment_circle_view.dart';

import 'custom_views/segment_circle_bottle_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SegmentCircleBottleAnimatedViewController segmentCircleAnimatedViewController = SegmentCircleBottleAnimatedViewController(["one", "two","three", "four", "five", "six"]);
  void _incrementCounter() {
    segmentCircleAnimatedViewController.runAnimation(springDescription: SpringDescription(
      mass: 2,
      stiffness: 10,
      damping: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        // child: SegmentCircleAnimatedView(segmentCircleController: segmentCircleAnimatedViewController,),
        child: SegmentCircleBottleAnimatedView(segmentCircleController: segmentCircleAnimatedViewController,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



}
