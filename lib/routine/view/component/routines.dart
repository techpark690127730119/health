import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/const/colors.dart';
import '../../../common/view/component/screen_util_padding.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../../drift/database/database.dart';
import '../../provider/calendar_provider.dart';
import '../../provider/routine_proivder.dart';
import 'package:go_router/go_router.dart';

class Routines extends ConsumerWidget {
  const Routines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 화면 사이즈
    final size = MediaQuery.of(context).size;

    // 선택 날짜
    final DateTime selectedDate = ref.watch(calendarProvider).selectedDate;

    // 선택 날
    final String selectedDay = ref
        .watch(calendarProvider.notifier)
        .selectedDay(selectedDate: selectedDate);
    
    // 1. 해당 요일에 저장된 루틴 가져오기
    return ref.watch(routineStreamProvider(selectedDate.weekday)).when(
          // 2. 루틴을 가져왔으면 Column으로 배치 
          data: (routines) => Container(
            height: size.height,
            padding: ScreenUtilPadding.symmetric(12, 8),
            child: Column(
              children: [
                // 요일 + 루틴 추가 버튼
                _renderTopBar(
                  context: context,
                  selectedDay: selectedDay,
                ),
                // 공간
                SizedBox(height: 8.h),
                // 나머지 공간엔 (Expanded) 루틴 카드
                Expanded(
                  child: _renderRoutineCard(
                    routines: routines,
                    ref: ref,
                  ),
                ),
              ],
            ),
          ),
          error: _renderErrorWidget,
          loading: _renderLoadingWidget,
        );
  }

  Widget _renderTopBar({
    required BuildContext context,
    required String selectedDay,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScreenUtilText(
          selectedDay,
          size: 24,
          weight: FontWeight.w700,
        ),
        GestureDetector(
          onTap: () {
            context.go("/add_routine_screen");
          },
          child: const Icon(
            CupertinoIcons.add_circled,
            color: white,
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget _renderRoutineCard({
    required WidgetRef ref,
    required List<HealthRoutineData> routines,
  }) {
    // 여러 개의 루틴을 itemCount 만큼 itemBuilder로 감싸서 리턴해 준다.
    return ListView.builder(
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return GestureDetector(
          onTap: () {
            context.push("/update_routine_screen");
          },
          child: Padding(
            padding: ScreenUtilPadding.symmetric(0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenUtilText(
                  routine.exercise.toString(),
                  size: 18,
                ),
                ScreenUtilText(
                  "${routine.set}세트",
                  size: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderErrorWidget(e, s) {
    return ScreenUtilText(e.toString());
  }

  Widget _renderLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: white,
        strokeWidth: 1,
      ),
    );
  }
}
