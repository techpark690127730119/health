import 'package:flutter/material.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.onChanged,
    this.textEditingController,
    required this.validator,
    super.key,
  });

  final baseBoder = const OutlineInputBorder(
    borderSide: BorderSide.none,
  );
  final baseTextStyle = const TextStyle(
    color: white,
    fontSize: 15,
    fontFamily: "main",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ScreenUtilPadding.symmetric(26, 6),
      child: TextFormField(
        controller: textEditingController,
        style: baseTextStyle,
        validator: validator,
        cursorColor: white,
        obscureText: obscureText,
        autofocus: autofocus,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorStyle: baseTextStyle.copyWith(
            color: red,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: baseTextStyle,
          fillColor: grey.withOpacity(0.5),
          filled: true,
          border: baseBoder,
          enabledBorder: baseBoder.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: baseBoder.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
