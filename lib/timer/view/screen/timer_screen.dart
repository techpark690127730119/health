import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plans/timer/util/cout_down_timer.dart';
import 'package:health_plans/timer/view/event/%08timer_screen_evnet.dart';
import 'package:numberpicker/numberpicker.dart';

class CountDownTimerScreen extends StatefulWidget {
  const CountDownTimerScreen({Key? key}) : super(key: key);

  @override
  State<CountDownTimerScreen> createState() => _CountDownTimerScreenState();
}

class _CountDownTimerScreenState extends State<CountDownTimerScreen>
    with SingleTickerProviderStateMixin, CountDownTimerScreenEvent {
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    stopWatchScale = Tween(begin: 0.5, end: 1.0).animate(animationController);
    timeSelectionFieldScale =
        Tween(begin: 1.0, end: 0.5).animate(animationController);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 124, bottom: 64),
              child: ScaleTransition(
                scale: timeSelectionFieldScale,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTimeField(
                      title: "분",
                      minValue: 0,
                      maxValue: 20,
                      currentValue: minute,
                      textMapper: minuteMapper,
                      onChanged: onMinuteChanged,
                    ),
                    const Text(
                      ":",
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                    buildTimeField(
                      title: "초",
                      minValue: 0,
                      maxValue: 60,
                      currentValue: second,
                      textMapper: secondMapper,
                      onChanged: onSecondChanged,
                    ),
                  ],
                ),
              ),
            ),
            ScaleTransition(
              scale: stopWatchScale,
              child: CustomPaint(
                painter: TimerCirclePainter(
                  progress: countdownSeconds / (minute * 60 + second),
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
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(
                  onTap: () {
                    forwardAnima();
                    initTimerOperation();
                  },
                  color: Colors.tealAccent,
                  label: "시작",
                ),
                buildButton(
                  onTap: () {
                    stopTimer();
                  },
                  color: Colors.orangeAccent,
                  label: "정지",
                ),
                buildButton(
                  onTap: () {
                    resetAnima();
                    resetTimer();
                  },
                  color: Colors.redAccent,
                  label: "초기화",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimeField({
    required String title,
    required int minValue,
    required int maxValue,
    required int currentValue,
    required String Function(String) textMapper,
    required void Function(int) onChanged,
  }) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 22)),
        NumberPicker(
          itemHeight: 60,
          infiniteLoop: true,
          textMapper: textMapper,
          selectedTextStyle: const TextStyle(color: Colors.red, fontSize: 38),
          textStyle: const TextStyle(color: Colors.grey, fontSize: 38),
          minValue: minValue,
          maxValue: maxValue,
          value: currentValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildButton({
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return MaterialButton(
      color: color,
      onPressed: onTap,
      child: Text(label),
    );
  }
}
