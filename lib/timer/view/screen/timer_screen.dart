import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plans/timer/util/cout_down_timer.dart';
import 'package:numberpicker/numberpicker.dart';

class CountDownTimerScreen extends StatefulWidget {
  const CountDownTimerScreen({Key? key}) : super(key: key);

  @override
  State<CountDownTimerScreen> createState() => _CountDownTimerScreenState();
}

class _CountDownTimerScreenState extends State<CountDownTimerScreen>
    with SingleTickerProviderStateMixin {
  int initSeconds = 0;
  int initMinutes = 0;
  int countdownSeconds = 0;

  late CountdownTimer countdownTimer;
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  
  // 애니메이션 타입 
  late Animation<double> timerScale =
      Tween(begin: 0.5, end: 1.0).animate(animationController);

  late Animation<double> timeScale = Tween(
    begin: 1.0,
    end: 0.5,
  ).animate(animationController);

  bool isTimerRunning = false;

  void forwardAnima() {
    setState(() {
      animationController.forward();
    });
  }

  void resetAnima() {
    setState(() {
      initMinutes = 0;
      initSeconds = 0;
      animationController.reverse();
    });
  }

  // 타이머를 생성한다.
  // 그리고 타이머는 1초마다 초기값을 감소시키고, 화면의 countdownSeconds 변수를 업데이트 한다.
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
      countdownSeconds = 0;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
              // 위젯의 크기를 애니메이션하고 싶으면 해당 위젯을 
              // ScaleTransition으로 감싸야 한다.
              child: ScaleTransition(
                scale: timeScale,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "분",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        // NumberPicker라는 패키지가 있다. 
                        NumberPicker(
                          // 숫자의 높이
                          itemHeight: 60,
                          // 무한 반복
                          infiniteLoop: true,
                          // 숫자를 보여줄 때 뭔가 추가할 게 있는 경우 사용
                          // Dart의 문자열 내장함수 padLeft로 2글자가 안되면 왼쪽에 0을 추가
                          textMapper: (numberText) {
                            return numberText.padLeft(2, '0');
                          },
                          // 지금 선택된 숫자 스타일
                          selectedTextStyle:
                              const TextStyle(color: Colors.red, fontSize: 38),
                          // 일반 숫자 스타일
                          textStyle:
                              const TextStyle(color: Colors.grey, fontSize: 38),
                          // 최소값
                          minValue: 0,
                          // 최대값
                          maxValue: 20,
                          // 선택된 숫자
                          value: initMinutes,
                          // 다음 숫자를 선택된 숫자로 만듬
                          onChanged: (value) {
                            setState(() {
                              // 전체 초를 계산해서 타이머를 업데이트
                              final int r = (countdownSeconds % 60).floor();
                              countdownSeconds = value * 60 + r;
                              initMinutes = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const Text(
                      ":",
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                    Column(
                      children: [
                        const Text(
                          "초",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        NumberPicker(
                          itemHeight: 60,
                          infiniteLoop: true,
                          textMapper: (numberText) {
                            return numberText.padLeft(2, '0');
                          },
                          selectedTextStyle:
                              const TextStyle(color: Colors.red, fontSize: 38),
                          textStyle:
                              const TextStyle(color: Colors.grey, fontSize: 38),
                          minValue: 0,
                          maxValue: 60,
                          value: initSeconds,
                          onChanged: (value) {
                            setState(() {
                              final int r = (countdownSeconds % 60).floor();
                              countdownSeconds = countdownSeconds - r + value;
                              initSeconds = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 플러터 제공 함수
            ScaleTransition(
              // 애니메이션 공식
              scale: timerScale,
              // 애니메이션을 적용할 위젯
              child: CustomPaint(
                painter: TimerCirclePainter(
                  progress: countdownSeconds / (initMinutes * 60 + initSeconds),
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
                MaterialButton(
                  color: Colors.tealAccent,
                  onPressed: () {
                    forwardAnima();
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
                    resetAnima();
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
