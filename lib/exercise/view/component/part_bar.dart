import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';
import 'package:health_plans/common/view/component/screen_util_text.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';

class PartBar extends ConsumerWidget {
  final bool? isRoutine;
  final String part;
  final PartData? partData;
  
  const PartBar({
    this.isRoutine,
    required this.part,
    this.partData,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: ScreenUtilPadding.only(12, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (partData != null) {
                    ref
                        .read(exerciseProvider.notifier)
                        .selectExercise(part: part, partData: partData);
                    context.go("/exercise_screen/update_part_screen");
                  }
                },
                child: ScreenUtilText(
                  part,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              if (isRoutine == null)
                GestureDetector(
                  onTap: () {
                    ref
                        .read(exerciseProvider.notifier)
                        .selectExercise(part: part);
                    context.go("/exercise_screen/add_exercise_screen");
                  },
                  child: const Icon(
                    Icons.add,
                    color: white,
                  ),
                )
            ],
          ),
          Container(
            margin: ScreenUtilPadding.only(0, 0, 12, 16),
            color: white,
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
