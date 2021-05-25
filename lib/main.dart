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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _end = Colors.black;

  void _incrementCounter() {
    setState(() {
      _end = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder<Color>(
                tween: Tween(begin: Colors.white, end: _end),
                duration: Duration(seconds: 2),
                builder: (context, color, child ){
                  return ColorFiltered(
                      child: Image.network(
                        "https://purepng.com/public/uploads/large/purepng.com-earthearthplanetglobethird-planet-from-the-sun-1411526987961jvz5u.png",
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
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
