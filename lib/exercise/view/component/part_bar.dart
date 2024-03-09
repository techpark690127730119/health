// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';
import 'package:health_plans/common/view/component/screen_util_text.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/view/screen/add_exercise_screen.dart';
import 'package:health_plans/exercise/view/screen/update_part_screen.dart';

enum PartBarType {
  CONST,
  CUSTOM,
  ROUTINE,
}

class PartBar extends ConsumerWidget {
  final String part;
  final PartData? partData;
  final PartBarType partBarType;

  const PartBar({
    required this.part,
    this.partData,
    required this.partBarType,
    super.key,
  });

  // 디폴트 파트 바
  factory PartBar.constant({
    required String part,
  }) {
    return PartBar(
      part: part,
      partBarType: PartBarType.CONST,
    );
  }

  // 커스텀 파트 바
  factory PartBar.custom({
    required String part,
    required PartData partData,
  }) {
    return PartBar(
      part: part,
      partData: partData,
      partBarType: PartBarType.CUSTOM,
    );
  }

  // 루틴용 파트 바
  factory PartBar.routine({
    required String part,
  }) {
    return PartBar(
      part: part,
      partBarType: PartBarType.ROUTINE,
    );
  }

  // 운동 추가
  void addExercise(
    BuildContext context,
    WidgetRef ref,
  ) {
    context.go(
      AddExerciseScreen.PATH,
      extra: part,
    );
  }

  // 운동 수정
  void updateExercise(
    BuildContext context,
    WidgetRef ref, {
    required PartData partData,
  }) {
    context.go(
      UpdatePartScreen.PATH,
      extra: partData,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 루틴일 경우
    if (partBarType == PartBarType.ROUTINE) {
      return renderPartBarPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renderPartName(),
            renderDivider(),
          ],
        ),
      );
      // 커스텀인 경우
    } else if (partBarType == PartBarType.CUSTOM) {
      return renderPartBarPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => updateExercise(
                    context,
                    ref,
                    partData: partData!,
                  ),
                  child: renderPartName(),
                ),
                GestureDetector(
                  onTap: () => addExercise(
                    context,
                    ref,
                  ),
                  child: renderAddIcon(),
                )
              ],
            ),
            renderDivider(),
          ],
        ),
      );
      // 기본의 경우
    } else {
      return renderPartBarPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                renderPartName(),
                GestureDetector(
                  onTap: () => addExercise(
                    context,
                    ref,
                  ),
                  child: renderAddIcon(),
                )
              ],
            ),
            renderDivider(),
          ],
        ),
      );
    }
  }

  Widget renderPartBarPadding({
    required Widget child,
  }) {
    const double leftPadding = 12;
    const double rightPadding = 12;
    const double topPadding = 16;
    const double bottomPadding = 0;

    return Padding(
      padding: ScreenUtilPadding.only(
        leftPadding,
        rightPadding,
        topPadding,
        bottomPadding,
      ),
      child: child,
    );
  }

  Widget renderPartName() {
    return ScreenUtilText(
      part,
      size: 20,
      weight: FontWeight.w700,
    );
  }

  Widget renderAddIcon() {
    return const Icon(
      Icons.add,
      color: white,
    );
  }

  Widget renderDivider() {
    const double leftPadding = 0;
    const double rightPadding = 0;
    const double topPadding = 12;
    const double bottomPadding = 16;
    const double dividerHeight = 0.5;

    return Container(
      margin: ScreenUtilPadding.only(
        leftPadding,
        rightPadding,
        topPadding,
        bottomPadding,
      ),
      color: white,
      height: dividerHeight,
    );
  }
}
