import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/calendar/calendar_provider.dart';
import '../../common/widget/app_color.dart';
import '../../common/widget/app_text.dart';
import '../../common/widget/app_padding.dart';
import '../setting/setting_screen.dart';
import 'widget/calendar.dart';
import 'widget/routines.dart';

final navigationbarProvider = StateProvider<int>((ref) {
  return 0;
});

class NavigationBarScreen extends ConsumerWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 바텀 네비게이션바 아이템
    BottomNavigationBarItem renderNavBarItem({
      required IconData iconData,
      required String label,
    }) {
      return BottomNavigationBarItem(
        icon: Icon(
          iconData,
          size: 28,
        ),
        label: label,
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(navigationbarProvider),
        onTap: (index) {
          ref.read(navigationbarProvider.notifier).state = index;
        },
        items: [
          renderNavBarItem(
            iconData: CupertinoIcons.calendar,
            label: "내 루틴",
          ),
          renderNavBarItem(
            iconData: CupertinoIcons.gear_alt_fill,
            label: "설정",
          ),
        ],
      ),
      body: _renderBody(ref: ref),
    );
  }

  Widget _renderBody({required WidgetRef ref}) {
    final currentIndex = ref.watch(navigationbarProvider);
    return currentIndex == 1 ? const SettingScreen() : const RoutineScreen();
  }
}

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(),
      body: _renderBody(context: context),
    );
  }

  PreferredSizeWidget _renderAppBar() {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          // 현재 보고 있는 페이지(캘린더) 정보
          final currentPageInfo = ref.watch(calendarProvider.select(
            (value) => value.focusedDate,
          ));

          return AppText(
            "${currentPageInfo.year}년 ${currentPageInfo.month}월",
            size: 24,
            weight: FontWeight.w700,
          );
        },
      ),
    );
  }

  Widget _renderBody({required BuildContext context}) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          padding: AppPadding.symmetric(8, 16),
          child: const Calendar(),
        ),
        Container(
          margin: AppPadding.symmetric(8, 8),
          color: white,
          height: 0.3,
        ),
        const Routines(),
      ],
    );
  }
}
