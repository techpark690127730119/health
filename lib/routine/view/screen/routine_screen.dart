import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/routine/view/screen/routine_screen_scaffold.dart';
import '../../../common/const/colors.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../../common/view/component/screen_util_padding.dart';
import '../../provider/calendar_provider.dart';
import '../component/calendar.dart';
import '../component/routines.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoutineScreenScaffold(
      appBar: _renderAppBar(),
      calendar: renderCalendar(),
      divider: renderDivider(),
      routines: renderRoutines(),
    );
  }

  PreferredSizeWidget _renderAppBar() {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          // 현재 보고 있는 페이지(캘린더) 정보
          final currentPageInfo = ref.watch(calendarProvider.select(
            (value) => value.focusedDate,
          ));

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScreenUtilText(
                "${currentPageInfo.year}년 ${currentPageInfo.month}월",
                size: 24,
                weight: FontWeight.w700,
              ),
              GestureDetector(
                onTap: () {
                  context.go("/exercise_screen");
                },
                child: const Icon(Icons.menu),
              )
            ],
          );
        },
      ),
    );
  }

  Widget renderCalendar() {
    return Container(
      padding: ScreenUtilPadding.symmetric(8, 16),
      child: const Calendar(),
    );
  }

  Widget renderDivider() {
    return Container(
      margin: ScreenUtilPadding.symmetric(8, 8),
      color: white,
      height: 0.5,
    );
  }

  Widget renderRoutines() {
    return const Routines();
  }
}
