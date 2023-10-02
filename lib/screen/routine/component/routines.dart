import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/app_colors.dart';
import '../../../common/widgets/app_padding.dart';
import '../../../common/widgets/app_text.dart';
import '../../../drift/database/database.dart';
import '../../../provider/calendar/calendar_provider.dart';

class Routines extends ConsumerWidget {
  const Routines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    //선택한 날짜
    final selectedDate = ref.watch(calendarProvider.select(
      (value) => value.selectedDate,
    ));
    //선택한 날
    final selectedDay = ref
        .read(calendarProvider.notifier)
        .selectedDay(selectedDate: selectedDate);
    //루틴 추가
    void addRoutine() {
      ref.read(calendarProvider.notifier).addRoutine();
    }

    return ref.watch(routineStreamProvider(selectedDate.weekday)).when(
          data: (routines) => _loadRoutines(
            selectedDate: selectedDate,
            selectedDay: selectedDay,
            addRoutine: addRoutine,
            size: size,
          ),
          error: _errorWidget,
          loading: _loadingWidget,
        );
  }

  Widget _loadRoutines({
    required DateTime selectedDate,
    required String selectedDay,
    required Function addRoutine,
    required Size size,
  }) {
    return Container(
      padding: AppPadding.symmetric(12, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                selectedDay,
                size: 24,
                weight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _loadRoutineCard({required List<HealthRoutineData> routines}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return AppText(routine.date.toString());
      },
    );
  }

  Widget _errorWidget(e, s) {
    return AppText(e.toString());
  }

  Widget _loadingWidget() {
    return const CircularProgressIndicator(color: white, strokeWidth: 1);
  }
}
