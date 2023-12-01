import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final BottomNavigationBar? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  const DefaultLayout({
    required this.child,
    this.bottomNavigationBar,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
