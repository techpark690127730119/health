import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/const/colors.dart';
import 'common/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: ref.read(goRouterProvider),
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
