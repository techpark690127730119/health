// ignore_for_file: slash_for_doc_comments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_plans/drift/database/database.dart';
import 'calendar_state.dart';

final calendarProvider =
    StateNotifierProvider<CalendarStateNotifier, CalendarState>(
  (ref) => CalendarStateNotifier(appDatabase: ref.read(databaseProvider)),
);

final routineStreamProvider =
    StreamProvider.family<List<HealthRoutineData>, int>((ref, dayId) {
  return ref.read(calendarProvider.notifier).watchRoutine(dayId: dayId);
});

class CalendarStateNotifier extends StateNotifier<CalendarState> {
  final AppDatabase appDatabase;
  CalendarStateNotifier({
    required this.appDatabase,
  }) : super(
          CalendarState(
            focusedDate: DateTime.now(),
            selectedDate: DateTime.now(),
          ),
        );

  // 페이지 변경 함수
  void onPageChanged({required DateTime currentPage}) {
    state = state.copyWith(focusedDate: currentPage);
  }

  // 날짜 선택 함수
  void selectDate(DateTime date) {
    state = state.copyWith(
      focusedDate: date,
      selectedDate: date,
    );
  }

  // 요일 선택 함수
  String selectedDay({required DateTime selectedDate}) {
    switch (selectedDate.weekday) {
      case 1:
        return "월요일";
      case 2:
        return "화요일";
      case 3:
        return "수요일";
      case 4:
        return "목요일";
      case 5:
        return "금요일";
      case 6:
        return "토요일";
      case 7:
        return "일요일";
      default:
        return "월요일";
    }
  }

  // 루틴 추가 함수
  void addRoutine() {
    appDatabase.addRoutine(
      data: HealthRoutineCompanion.insert(
        date: state.selectedDate,
        dayId: state.selectedDate.weekday,
        part: "part",
        exercise: "exercise",
        set: 2,
      ),
    );
  }

  // 루틴 확인 함수
  Stream<List<HealthRoutineData>> watchRoutine({required int dayId}) {
    return appDatabase.watchRoutine(dayId: dayId);
  }
}
