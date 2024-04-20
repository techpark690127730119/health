import 'dart:async';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:health_plans/timer/util/timer_handler.dart';

class CountdownTimer {
  int _countdownSeconds;
  late Timer _timer;
  final Function(int)? _onTick;
  final Function()? _onFinished;
  final timerHandler = TimerDifferenceHandler.instance;
  bool onPausedCalled = false;

  CountdownTimer({
    required int seconds,
    Function(int)? onTick,
    Function()? onFinished,
  })  : _countdownSeconds = seconds,
        _onTick = onTick,
        _onFinished = onFinished;

  // 1. CountdownTimer 생성 시 초기값을 넣어준다
  // 2. CountdownTimer는 초기값을 _countdownSeconds에 저장한다.
  // 3. 그리고 1초가 지날 때마다 저장해둔 초기값에서 1씩 뺀다.
  // 4. 그다음 onTick 함수를 실행시킨다.

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownSeconds--;
      if (_onTick != null) {
        _onTick!(_countdownSeconds);
      }

      if (_countdownSeconds <= 0) {
        stop();
        if (_onFinished != null) {
          _onFinished!();
        }
      }
    });
  }

  void pause(int endTime) {
    // 일단 앱이 멈췄었다는 것을 기록한다.
    onPausedCalled = true;
    // 타이머 멈춘다 (타이머는 어차피 마지막 시간만 알면 그대로 다시 생성할 수 있기 때문)
    stop();
    // 마지막 시간 기록 
    timerHandler.setEndingTime(endTime);
  }

  // 앱이 멈춤 상태에서
  // 다시 앱을 켜서 정상 상태가 됐을 때
  // resume 항수가 실행된다.
  // 이때 resume 함수는 남아있는 시간을 계산해서 다시 자동으로 실행시킵니다.

  void resume() {
    // onPausedCalled은 앱이 멈췄었을 때 true입니다.
    if (!onPausedCalled) {
      return;
    }

    if (timerHandler.remainingSeconds > 0) {
      _countdownSeconds = timerHandler.remainingSeconds;
      start();
    } else {
      stop();
      _onTick!(_countdownSeconds);
    }
    onPausedCalled = false;
  }

  void stop() {
    _timer.cancel();
    _countdownSeconds = 0;
  }
}

class TimerCirclePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor, color;

  TimerCirclePainter({
    required this.progress,
    required this.backgroundColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double angle = 2 * math.pi * progress;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    paint.color = color;
    canvas.drawArc(
      Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2,
      ),
      math.pi * 1.5,
      -angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant TimerCirclePainter old) {
    return progress != old.progress;
  }
}
