import 'package:flutter/material.dart';
import 'package:health_plans/timer/util/cout_down_timer.dart';
import 'package:health_plans/timer/view/screen/timer_screen.dart';

mixin CountDownTimerScreenEvent on State<CountDownTimerScreen> {
  int minute = 0;
  int second = 0;
  int countdownSeconds = 0;

  bool isTimerRunning = false;

  late CountdownTimer countdownTimer;
  late AnimationController animationController;
  late Animation<double> stopWatchScale;
  late Animation<double> timeSelectionFieldScale;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void forwardAnima() {
    setState(() {
      animationController.forward();
    });
  }

  void resetAnima() {
    setState(() {
      minute = 0;
      second = 0;
      animationController.reverse();
    });
  }

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
        resetAnima();
      },
    );

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
      countdownSeconds = 0;
    });
  }

  void onMinuteChanged(int value) {
    setState(() {
      final int r = (countdownSeconds % 60).floor();
      countdownSeconds = value * 60 + r;
      minute = value;
    });
  }

  void onSecondChanged(int value) {
    setState(() {
      final int r = (countdownSeconds % 60).floor();
      countdownSeconds = countdownSeconds - r + value;
      second = value;
    });
  }

  String minuteMapper(String numberText) {
    return numberText.padLeft(2, '0');
  }

  String secondMapper(String numberText) {
    return numberText.padLeft(2, '0');
  }
}
