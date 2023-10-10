import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widget/app_color.dart';
import '../../../common/widget/app_padding.dart';
import '../../../common/widget/app_text.dart';
import '../../../drift/database/database.dart';
import '../../../provider/calendar/calendar_provider.dart';

class Routines extends ConsumerWidget {
  const Routines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 화면 사이즈
    final size = MediaQuery.of(context).size;

    // 선택 날짜
    final selectedDate = ref.watch(calendarProvider.select(
      (value) => value.selectedDate,
    ));

    // 선택 날
    final selectedDay = ref
        .read(calendarProvider.notifier)
        .selectedDay(selectedDate: selectedDate);

    // 루틴 추가
    void addRoutine() {
      ref.read(calendarProvider.notifier).addRoutine();
    }

    return ref.watch(routineStreamProvider(selectedDate.weekday)).when(
          data: (routines) => _renderRoutines(
            size: size,
            addRoutine: addRoutine,
            selectedDay: selectedDay,
            selectedDate: selectedDate,
            routines: routines,
          ),
          error: _renderErrorWidget,
          loading: _renderLoadingWidget,
        );
  }

  Widget _renderRoutines({
    required Size size,
    required Function addRoutine,
    required String selectedDay,
    required DateTime selectedDate,
    required List<HealthRoutineData> routines,
  }) {
    return Container(
      height: size.height,
      padding: AppPadding.symmetric(12, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                selectedDay,
                size: 24,
                weight: FontWeight.w700,
              ),
              GestureDetector(
                onTap: () => addRoutine(),
                child: const Icon(
                  CupertinoIcons.add_circled,
                  color: white,
                  size: 32,
                ),
              ),
            ],
          ),
          Expanded(
            child: _renderRoutineCard(routines: routines),
          ),
        ],
      ),
    );
  }

  Widget _renderRoutineCard({required List<HealthRoutineData> routines}) {
    return ListView.builder(
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return Padding(
          padding: AppPadding.symmetric(0, 8),
          child: AppText(routine.exercise),
        );
      },
    );
  }

  Widget _renderErrorWidget(e, s) {
    return AppText(e.toString());
  }

  Widget _renderLoadingWidget() {
    return const CircularProgressIndicator(
      color: white,
      strokeWidth: 1,
    );
  }
}
