import 'package:flutter/material.dart';
import 'package:health_plans/common/layout/default_layout.dart';

class RoutineScreenScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: appBar,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          calendar,
          divider,
          routines,
        ],
      ),
    );
  }
}
