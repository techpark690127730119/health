import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/const/data.dart';
import 'package:health_plans/common/layout/default_layout.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';
import 'package:health_plans/common/view/component/screen_util_text.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';
import 'package:health_plans/exercise/view/component/part_bar.dart';
import 'package:health_plans/exercise/view/screen/add_part_screen.dart';
import '../component/exercise_card.dart';

class ExerciseListScreen extends ConsumerWidget {
  const ExerciseListScreen({
    super.key,
  });

  void goAddPartScreen(BuildContext context) {
    context.go(
      AddPartScreen.PATH,
    );
  }

  void deletePart(
    WidgetRef ref, {
    required PartData partData,
  }) {
    ref
        .read(
          exerciseNotifierProvider.notifier,
        )
        .deletePart(
          id: partData.id,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBar: renderAppBar(
        context,
      ),
      child: ListView(
        children: [
          ...renderDefaultParts(),
          ...renderCustomParts(
            ref,
          ),
          renderAddPartButton(
            context,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget renderAppBar(BuildContext context) {
    return AppBar(
      title: const ScreenUtilText(
        "운동 목록",
        size: 24,
        weight: FontWeight.w700,
      ),
    );
  }

  List<Widget> renderDefaultParts() {
    return Data.defaultPart.map((defaultPart) {
      return Column(
        children: [
          PartBar.constant(
            part: defaultPart,
          ),
          renderExercise(
            part: defaultPart,
          ),
        ],
      );
    }).toList();
  }

  Widget renderExercise({
    required String part,
  }) {
    return Exercises(
      part: part,
    );
  }

  List<Widget> renderCustomParts(WidgetRef ref) {
    return ref
        .watch(
          partStreamProvider,
        )
        .when(
          data: (partDataList) {
            return partDataList.map(
              (partData) {
                return Column(
                  children: [
                    renderDismissiblePart(
                      ref,
                      partData: partData,
                    ),
                    renderExercise(
                      part: partData.part,
                    ),
                  ],
                );
              },
            ).toList();
          },
          error: (error, stackTrace) => [
            const SizedBox(),
          ],
          loading: () => [
            const SizedBox(),
          ],
        );
  }

  Widget renderDismissiblePart(
    WidgetRef ref, {
    required PartData partData,
  }) {
    return Dismissible(
      key: ObjectKey(
        partData,
      ),
      onDismissed: (direction) => deletePart(
        ref,
        partData: partData,
      ),
      child: PartBar.custom(
        part: partData.part,
        partData: partData,
      ),
    );
  }

  Widget renderAddPartButton(BuildContext context) {
    const double horizontalMargin = 0;
    const double verticalMargin = 24;
    const double horizontalPadding = 0;
    const double verticalPadding = 16;

    return GestureDetector(
      onTap: () => goAddPartScreen(
        context,
      ),
      child: Container(
        margin: ScreenUtilPadding.symmetric(
          horizontalMargin,
          verticalMargin,
        ),
        padding: ScreenUtilPadding.symmetric(
          horizontalPadding,
          verticalPadding,
        ),
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
