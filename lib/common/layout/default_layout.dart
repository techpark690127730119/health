import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Future<bool> Function()? onWillPop;
  final Widget child;
  final BottomNavigationBar? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  const DefaultLayout({
    this.onWillPop,
    required this.child,
    this.bottomNavigationBar,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appBar,
        body: child,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
