import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/app_colors.dart';
import '../../../common/widgets/app_padding.dart';
import '../../../common/widgets/app_text.dart';
import '../../../provider/calendar/calendar_provider.dart';

class Plans extends ConsumerWidget {
  const Plans({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //선택한 날짜
    final selectedDate = ref.watch(calendarProvider.select(
      (value) => value.selectedDate,
    ));
    return Container(
      padding: AppPadding.symmetric(12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            "${selectedDate.month}월 ${selectedDate.day}일 일정",
            size: 20,
            weight: FontWeight.bold,
          ),
          GestureDetector(
            child: const Icon(
              CupertinoIcons.chevron_down_circle,
              color: white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
