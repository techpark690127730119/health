import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/calendar_model.dart';

final calendarProvider =
    StateNotifierProvider<CalendarStateNotifier, CalendarModel>(
  (ref) => CalendarStateNotifier(),
);

class CalendarStateNotifier extends StateNotifier<CalendarModel> {
  CalendarStateNotifier()
      : super(
          CalendarModel(
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
}
