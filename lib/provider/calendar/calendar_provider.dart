import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calendar_state.dart';

final calendarProvider =
    StateNotifierProvider<CalendarStateNotifier, CalendarState>(
  (ref) => CalendarStateNotifier(),
);

class CalendarStateNotifier extends StateNotifier<CalendarState> {
  CalendarStateNotifier() : super(CalendarState(focusedDate: DateTime.now()));

  void selectDate(DateTime date) {
    state = state.copyWith(
      focusedDate: date,
      selectedDay: date,
    );
  }

  void onPageChanged({required DateTime currentPage}) {
    state = state.copyWith(focusedDate: currentPage);
  }
}
