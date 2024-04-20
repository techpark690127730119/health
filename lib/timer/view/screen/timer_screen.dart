import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plans/timer/util/cout_down_timer.dart';

class CountDownTimerScreen extends StatefulWidget {
  const CountDownTimerScreen({Key? key}) : super(key: key);

  @override
  State<CountDownTimerScreen> createState() => _CountDownTimerScreenState();
}

class _CountDownTimerScreenState extends State<CountDownTimerScreen> {
  int countdownSeconds = 180;
  late CountdownTimer countdownTimer;

  bool isTimerRunning = false;

  void initTimerOperation() {
    countdownTimer = CountdownTimer(
      seconds: countdownSeconds,
      onTick: (seconds) {
        isTimerRunning = true;
        setState(() {
          countdownSeconds = seconds;
        });
      },
      onFinished: () {
        stopTimer();
      },
    );

    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer.pause(countdownSeconds);
        }
      }

      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer.resume();
        }
      }
      return Future(() => null);
    });

    isTimerRunning = true;
    countdownTimer.start();
  }

  void stopTimer() {
    isTimerRunning = false;
    countdownTimer.stop();
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      countdownSeconds = 180;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: TimerCirclePainter(
                progress: countdownSeconds / 180,
                backgroundColor: Colors.grey,
                color: Colors.blue,
              ),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    '$countdownSeconds',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.tealAccent,
                  onPressed: () {
                    initTimerOperation();
                  },
                  child: const Text("시작"),
                ),
                MaterialButton(
                  color: Colors.orangeAccent,
                  onPressed: () {
                    stopTimer();
                  },
                  child: const Text("정지"),
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    resetTimer();
                  },
                  child: const Text("초기화"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
