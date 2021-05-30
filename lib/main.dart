import 'package:flutter/material.dart';
import 'package:simple_animation/src/widgets/cat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  late AnimationController catController =
  AnimationController(duration: Duration(seconds: 1), vsync: this)
      ..repeat();

  late Animation<double> catAnimation =
    Tween<double> (begin: 0, end: 100).animate(
    CurvedAnimation(
      curve: Curves.easeInOut,
      parent: catController)
    );


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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildCatAnimation(),
          ],
        ),
      ),
    );
  }

  Widget buildCatAnimation(){
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (BuildContext context, Widget? child){
          return Container(
            margin: EdgeInsets.only(bottom: catAnimation.value),
              child: Cat(),
          );
        },
      child: Cat(),
    );
  }

}
