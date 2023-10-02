import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_plans/common/widgets/app_text.dart';
import 'package:health_plans/screen/routine/component/calendar.dart';
// import 'package:health_plans/screen/routine/component/plans.dart';
import '../../common/widgets/app_colors.dart';
import '../../common/widgets/app_padding.dart';
import '../../provider/calendar/calendar_provider.dart';
import '../setting/setting_screen.dart';
import 'component/routines.dart';

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
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          padding: AppPadding.symmetric(8, 16),
          child: const Calendar(),
        ),
        // Container(
        //   margin: AppPadding.symmetric(8, 8),
        //   color: white,
        //   height: 0.3,
        // ),
        // const Plans(),
        Container(
          margin: AppPadding.symmetric(8, 8),
          color: white,
          height: 0.3,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Routines(),
        ),
      ],
    );
  }
}
