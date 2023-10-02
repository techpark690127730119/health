import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  static EdgeInsets symmetric(double horizontal, double vertical) {
    return EdgeInsets.symmetric(
      horizontal: horizontal.w,
      vertical: vertical.h,
    );
  }

  static EdgeInsets only(double left, double right, double top, double bottom) {
    return EdgeInsets.only(
      left: left.w,
      right: right.w,
      top: top.h,
      bottom: bottom.h,
    );
  }

    static EdgeInsets keyboardPadding(double left, double right, double top, double bottom) {
    return EdgeInsets.only(
      left: left.w,
      right: right.w,
      top: top.h,
      bottom: bottom,
    );
  }
}
