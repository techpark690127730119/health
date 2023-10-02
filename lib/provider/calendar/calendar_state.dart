class CalendarState {
  final DateTime focusedDate;
  final DateTime? selectedDay;

  CalendarState({
    required this.focusedDate,
    this.selectedDay,
  });

  CalendarState copyWith({
    DateTime? focusedDate,
    DateTime? selectedDay,
  }) {
    return CalendarState(
      focusedDate: focusedDate ?? this.focusedDate,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
