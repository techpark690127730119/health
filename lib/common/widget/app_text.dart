import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const AppText(
    this.text, {
    this.color,
    this.size = 16,
    this.weight = FontWeight.w500,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? white;
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: size!.sp,
        fontWeight: weight,
        fontFamily: "main",
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
