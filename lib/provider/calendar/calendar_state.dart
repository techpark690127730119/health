class CalendarState {
  final DateTime focusedDate;
  final DateTime selectedDate;

  CalendarState({
    required this.focusedDate,
    required this.selectedDate,
  });

  CalendarState copyWith({
    DateTime? focusedDate,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      focusedDate: focusedDate ?? this.focusedDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
