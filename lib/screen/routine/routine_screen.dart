import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_plans/common/widgets/app_text.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../common/widgets/app_colors.dart';
import '../../common/widgets/app_padding.dart';
import '../../provider/calendar/calendar_provider.dart';
import '../setting/setting_screen.dart';

final navigationbarProvider = StateProvider<int>((ref) {
  return 0;
});

class NavigationBars extends ConsumerWidget {
  const NavigationBars({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(navigationbarProvider),
        onTap: (index) {
          ref.read(navigationbarProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar, size: 28),
            label: "내 루틴",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt_fill, size: 28),
            label: "설정",
          ),
        ],
      ),
      body: _loadBody(ref: ref),
    );
  }

  Widget _loadBody({required WidgetRef ref}) {
    final currentIndex = ref.watch(navigationbarProvider);
    if (currentIndex == 1) {
      return const SettingScreen();
    }
    return const RoutineScreen();
  }
}

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _loadAppBar(),
      body: _loadBody(context: context),
    );
  }

  PreferredSizeWidget _loadAppBar() {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          final currentPageInfo = ref.watch(calendarProvider.select(
            (value) => value.focusedDate,
          ));
          return AppText(
            "${currentPageInfo.year}년 ${currentPageInfo.month}월",
            size: 24,
            weight: FontWeight.bold,
          );
        },
      ),
    );
  }

  Widget _loadBody({required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: AppPadding.only(8, 8, 16, 0),
            width: size.width,
            height: size.height * 0.5,
            child: const Calendar(),
          ),
        ],
      ),
    );
  }
}

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
        return calendarState.selectedDay == day ? true : false;
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
