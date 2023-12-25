import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/layout/default_layout.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';
import 'package:health_plans/common/view/component/screen_util_text.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';
import 'package:health_plans/exercise/view/component/part_bar.dart';

import '../component/exercise_card.dart';

class ExerciseListScreen extends ConsumerWidget {
  const ExerciseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPart = ["가슴", "등", "어깨", "하체", "팔"];

    return DefaultLayout(
      appBar: _renderAppBar(context),
      child: ListView(
        children: [
          ...defaultPart
              .map(
                (e) => Column(
                  children: [
                    PartBar(part: e),
                    Exercises(part: e),
                  ],
                ),
              )
              .toList(),
          ...ref.watch(partStreamProvider).when(
                data: (data) {
                  return data
                      .map((e) => Column(
                            children: [
                              Dismissible(
                                key: ObjectKey(e),
                                onDismissed: (direction) {
                                  ref
                                      .read(exerciseProvider.notifier)
                                      .deletePart(id: e.id);
                                },
                                child: PartBar(
                                  part: e.part,
                                  partData: e,
                                ),
                              ),
                              Dismissible(
                                key: ObjectKey("${e}2"),
                                onDismissed: (direction) {},
                                child: Exercises(part: e.part),
                              ),
                            ],
                          ))
                      .toList();
                },
                error: (error, stackTrace) => [
                  const SizedBox(),
                ],
                loading: () => [
                  const SizedBox(),
                ],
              ),
          renderAddPartButton(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) {
    return AppBar(
      title: const ScreenUtilText(
        "운동 목록",
        size: 24,
        weight: FontWeight.w700,
      ),
    );
  }

  Widget renderAddPartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/exercise_screen/add_part_screen");
      },
      child: Container(
        margin: ScreenUtilPadding.symmetric(0, 24),
        padding: ScreenUtilPadding.symmetric(0, 16),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: ScreenUtilText(
            "부위 추가",
            color: black,
            weight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
