import 'package:flutter/material.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/timer/view/screen/timer_screen.dart';

import '../../../routine/view/screen/routine_screen.dart';
import '../../layout/default_layout.dart';

class RootScreen extends StatefulWidget {
  static String get routeName => "home";
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with SingleTickerProviderStateMixin {
  int _index = 0;
  late final _tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultLayout(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: white,
          unselectedItemColor: white,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
            _tabController.animateTo(value);
          }),
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "루틴",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "타이머",
            ),
          ],
        ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            RoutineScreen(),
            CountDownTimerScreen(),
          ],
        ),
      ),
    );
  }
}
