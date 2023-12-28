import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyShapeChangingApp(),
    );
  }
}

class MyShapeChangingApp extends StatefulWidget {
  @override
  _MyShapeChangingAppState createState() => _MyShapeChangingAppState();
}

class _MyShapeChangingAppState extends State<MyShapeChangingApp> {
  late Timer _timer;
  bool _isChangingShape = false;
  bool _isRectangle = true;

  void _startShapeChange() {
    // Start a timer that toggles between rectangle and triangle every 0.5 seconds
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isRectangle = !_isRectangle;
      });
    });
  }

  void _stopShapeChange() {
    // Stop the timer to halt the shape-changing loop
    _timer.cancel();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shape Changing App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _isRectangle ? RectanglePainter() : TrianglePainter(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isChangingShape = true;
                    });
                    _startShapeChange();
                  },
                  child: Text('START'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isChangingShape = false;
                    });
                    _stopShapeChange();
                  },
                  child: Text('STOP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the rectangle
class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Custom painter for the triangle
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.green;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
