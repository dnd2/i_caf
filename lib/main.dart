import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_caf/pages/Login.dart';

import 'pages/Login.dart';
import 'package:i_caf/components/ui/progressbar/CircleProgressBar.dart';

/// 版本冲突： https://juejin.im/post/5b8958d351882542b03e6d57
/// stream： https://juejin.im/post/5e9b6aacf265da47bd1bb0d9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ford Dealer App',
      theme: ThemeData(
        platform: TargetPlatform.iOS, // widget应该适应目标的平台
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
       // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //initialRoute: '/',
      home: StreamCounter()
    );
  }
}

class StreamCounter extends StatefulWidget {
  @override
  _StreamCounterState createState() => _StreamCounterState();
}

class _StreamCounterState extends State<StreamCounter> {
  StreamController<int> _counterStreamController = StreamController<int>(
    onCancel: () {
      print('cancel');
    },
    onListen: () {
      print('listen');
    }
  );
  int _counter = 0;
  Stream _counterStream;
  StreamSink _counterSink;

  void _incrementCounter() {
    if (_counter > 9) {
      _counterSink.close();
      return;
    }
    _counter++;
    _counterSink.add(_counter);
  }
  

  void _closeStream() {
    _counterStreamController.close();
  }

  @override
  void initState() {
    super.initState();
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;
  }

  @override
  void dispose() {
    super.dispose();
    _counterSink.close();
    _counterStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times.'),
            StreamBuilder<int>(
              stream: _counterStream,
              initialData: _counter,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'Done',
                    style: Theme.of(context).textTheme.body1,
                  );
                }

                int number = snapshot.data;
                return Text(
                  '$number',
                  style: Theme.of(context).textTheme.body2,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 24.0),
          FloatingActionButton(
            onPressed: _closeStream,
            tooltip: 'Close',
            child: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}


class LineProgressBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = [
      Offset(0,0),
      Offset(30,50),
      Offset(20,80),
      Offset(100, 40),
      Offset(150, 90),
      Offset(60, 110),
      Offset(260, 160),
    ];
    var paint = Paint()
      ..color = Color(0xffff0000)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    canvas.drawPoints(PointMode.polygon, points, paint);
    canvas.drawLine(Offset(30,30), Offset(100,170), paint);
    canvas.drawRRect(RRect.fromLTRBAndCorners(10, 6, 200, 20), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 30;
    double eHeight = size.height / 30;

    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill // 填充
      ..color = Color(0x77cdb175); // 背景为纸黄色
    /// Rect.fromPoints 根据两个点(左上角点/右下角点)来绘制；
    /// Rect.fromLTRB 根据以屏幕左上角为坐标系圆点，分别设置上下左右四个方向距离；
    /// Rect.fromLTWH 根据设置左上角的点与矩形宽高来绘制；
    /// Rect.fromCircle 最特殊，根据圆形绘制正方形；
    /** 
     *  canvas.drawRect(Rect.fromPoints(Offset(30.0, 30.0), Offset(150.0, 100.0)),
    Paint()..color = Colors.white..strokeWidth = 4.0..style = PaintingStyle.stroke);
canvas.drawRect(Rect.fromPoints(Offset(210.0, 30.0), Offset(330.0, 100.0)),
    Paint()..color = Colors.white..style = PaintingStyle.fill);
canvas.drawRect(Rect.fromLTRB(30.0, 140.0, 150.0, 210.0),
    Paint()..color = Colors.white);
canvas.drawRect(Rect.fromLTWH(210.0, 140.0, 120.0, 70.0),
    Paint()..color = Colors.white);
canvas.drawRect(Rect.fromCircle(center: Offset(90.0, 300.0), radius: 60.0),
    Paint()..color = Colors.white..strokeWidth = 4.0..style = PaintingStyle.stroke);
    canvas.drawRect(Offset.zero & size, paint); 
    */

    paint
      ..style = PaintingStyle.stroke
      ..color = Color(0xff888888)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 30; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 30; ++i) {
       double dx = eWidth * i;
       canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint); 
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}