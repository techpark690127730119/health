class CalendarModel {
  final DateTime focusedDate;
  final DateTime selectedDate;

  CalendarModel({
    required this.focusedDate,
    required this.selectedDate,
  });

  CalendarModel copyWith({
    DateTime? focusedDate,
    DateTime? selectedDate,
  }) {
    return CalendarModel(
      focusedDate: focusedDate ?? this.focusedDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
