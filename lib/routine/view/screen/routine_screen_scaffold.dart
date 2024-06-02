import 'package:flutter/material.dart';
import 'package:health_plans/common/layout/default_layout.dart';

class RoutineScreenScaffold extends StatefulWidget {
  // 앱바
  final PreferredSizeWidget appBar;

  // 캘린더
  final Widget calendar;

  // 구분선
  final Widget divider;

  // 루틴
  final Widget routines;

  const RoutineScreenScaffold({
    super.key,
    required this.appBar,
    required this.calendar,
    required this.divider,
    required this.routines,
  });

  @override
  State<RoutineScreenScaffold> createState() => _RoutineScreenScaffoldState();
}

class _RoutineScreenScaffoldState extends State<RoutineScreenScaffold>
    with SingleTickerProviderStateMixin {
  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: widget.appBar,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          setState(() {
            _scrollOffset = scrollInfo.metrics.pixels;
          });
          return true;
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Transform.scale(
              scale: _calculateScale(),
              child: widget.calendar,
            ),
            widget.divider,
            widget.routines,
          ],
        ),
      ),
    );
  }

  double _calculateScale() {
    double minScale = 0.5; // 캘린더의 최소 스케일
    double maxScrollExtent = 300.0; // 스크롤 범위

    double scale = 1.0 - (_scrollOffset / maxScrollExtent);
    if (scale < minScale) {
      return minScale;
    }
    return scale;
  }
}
