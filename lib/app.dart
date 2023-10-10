import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_plans/screen/routine/routine_screen.dart';

import 'common/widget/app_color.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;
  @override
  void initState() {
    super.initState();
    _goRouter = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const NavigationBarScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _goRouter,
        theme: ThemeData(
          scaffoldBackgroundColor: black,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
            backgroundColor: black,
            foregroundColor: white,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: black,
            selectedItemColor: white,
            unselectedItemColor: grey,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: white,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              fontFamily: "main",
            ),
            unselectedLabelStyle: TextStyle(
              color: grey6,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              fontFamily: "main",
            ),
          ),
        ),
      ),
    );
  }
}
