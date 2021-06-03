import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:simple_animation/src/widgets/cat.dart';
import 'package:flutter/rendering.dart';


void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Animations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  late AnimationController catController =
  AnimationController(duration: Duration(seconds: 3), vsync: this);
      

  late Animation<double> catAnimation =
    Tween<double> (begin: -45, end: -80).animate(
    CurvedAnimation(
      curve: Curves.easeInOut,
      parent: catController,
      reverseCurve: Curves.easeIn,
      )
    );

  late AnimationController handController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
  )..forward();

  late Animation<double> handAnimation = Tween<double>(begin: Math.pi * 2/3, end: Math.pi * 3/4)
  .animate(CurvedAnimation(parent: handController, curve: Curves.bounceIn),)
  ..addStatusListener((status) {
    if(status == AnimationStatus.dismissed) {
      handController.forward();
    }else if(status == AnimationStatus.completed){
      handController.reverse();
    }
  });


  // @override
  // void initState(){
  //   super.initState();
  //   catController!.forward();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: InkWell(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildCatAnimation(),
                _buildBox(),
                _buildLeftHand(),
                _buildRightHand(),

              ],
            ),
            onTap: onTap,
        ),
      ),
    );
  }


  Widget _buildBox() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.brown.shade200,
    );
  }

  Widget _buildCatAnimation(){
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (BuildContext context, Widget? child){
          return Positioned(
              top: catAnimation.value,
              left: 0,
              right: 0,
              child: child!,
          );
        },
      child: Cat(),
    );
  }



  void onTap() {
    if(catAnimation.status == AnimationStatus.dismissed ||
        catAnimation.status == AnimationStatus.reverse) {
      catController.forward();
    }else if(catAnimation.status == AnimationStatus.completed ||
        catAnimation.status == AnimationStatus.forward ){
      catController.reverse();
    }

  }

  Widget _buildLeftHand() {
    return AnimatedBuilder(
      animation: handAnimation,
      builder: (context, Widget? child) {
        return Transform.rotate(
          angle: handAnimation.value,
          alignment: Alignment.topLeft,
          origin: Offset(3,3),
          child:child,
        );
      },
      child: Container(
      width: 100,
      height: 18,
      color: Colors.brown.shade200,
    ),
    );
  }

  Widget _buildRightHand() {
    return Positioned(
      right: 6,
      top: 4,
      child: AnimatedBuilder(
        animation: handAnimation,
        builder: (context, Widget? child) {
          return Transform.rotate(
            angle: -handAnimation.value,
            alignment: Alignment.topRight,
            child:child,
          );
        },
        child: Container(
          width: 100,
          height: 19,
          color: Colors.brown.shade200,
        ),
      ),
    );
  }

}







