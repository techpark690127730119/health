import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  StopwatchScreenState createState() => StopwatchScreenState();
}

class StopwatchScreenState extends State<StopwatchScreen> {
  late final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final seconds = (_stopwatch.elapsedMilliseconds / 1000).floor();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: StopwatchPainter(_stopwatch),
              size: const Size(200, 200),
            ),
            const SizedBox(
                height: 24), // Adjusted the height for better spacing
            Text(
              '$seconds 초',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: const Text('시작'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  child: const Text('정지'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('리셋'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StopwatchPainter extends CustomPainter {
  final Stopwatch stopwatch;

  StopwatchPainter(this.stopwatch);

  @override
  void paint(Canvas canvas, Size size) {
    final angle =
        (stopwatch.elapsedMilliseconds / 1000) * 6 * pi / 180 - pi / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final borderPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      size.width / 2,
      borderPaint,
    );

    canvas.drawCircle(
      center,
      size.width / 2,
      paint,
    );

    canvas.drawLine(
      center,
      Offset(
        center.dx + cos(angle) * size.width / 2,
        center.dy + sin(angle) * size.width / 2,
      ),
      paint..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
