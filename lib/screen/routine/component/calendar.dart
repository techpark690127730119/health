
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/widgets/app_colors.dart';
import '../../../provider/calendar/calendar_provider.dart';

class Calendar extends ConsumerWidget {
  const Calendar({super.key});

  TextStyle _calendarTextStyle({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "main",
    );
  }

  BoxDecoration _calendarBoxDeco({required Color color}) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
    final calendarStateNotifier = ref.read(calendarProvider.notifier);
    return TableCalendar(
      locale: "ko_KR",
      firstDay: DateTime.utc(2022, 9, 25),
      lastDay: DateTime.utc(2050, 12, 25),
      focusedDay: calendarState.focusedDate,
      headerVisible: false,
      calendarStyle: CalendarStyle(
        todayDecoration: _calendarBoxDeco(color: red),
        selectedDecoration: _calendarBoxDeco(color: red),
        defaultTextStyle: _calendarTextStyle(color: white),
        todayTextStyle: _calendarTextStyle(color: white),
        weekendTextStyle: _calendarTextStyle(color: red),
        selectedTextStyle: _calendarTextStyle(color: white),
      ),
      selectedDayPredicate: (day) {
        return calendarState.selectedDate == day ? true : false;
      },
      onDaySelected: (selectedDay, focusedDay) {
        calendarStateNotifier.selectDate(selectedDay);
      },
      onPageChanged: (currentPage) {
        calendarStateNotifier.onPageChanged(currentPage: currentPage);
      },
    );
  }
}
