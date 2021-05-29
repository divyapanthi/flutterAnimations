import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  Color _end = Colors.black;

  Future<void> _incrementCounter() async {
    setState(() {
      _end = Colors.blue;
    });

    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _end = Colors.red;
    });
  }

  int counter = 0;

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
            TweenAnimationBuilder<Color>(
                tween: Tween(begin: Colors.white, end: _end),
                duration: Duration(seconds: 2),
                onEnd: (){
                  setState(() {
                    _end = Colors.primaries[Random().nextInt(17)];
                  });
                },
                child:  Image.network(
                  "https://www.businessinsider.in/thumb.cms?msid=73771721&width=1200&height=900",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                builder: (context, color, child ){
                  counter ++;
                  print("counter $counter");

                  return ColorFiltered(
                      child: child,
                      colorFilter: ColorFilter.mode(color, BlendMode.color)
                  );
                },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
