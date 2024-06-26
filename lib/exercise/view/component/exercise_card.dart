import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/const/colors.dart';
import 'package:health_plans/common/view/component/screen_util_padding.dart';
import 'package:health_plans/common/view/component/screen_util_text.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/provider/exercise_provider.dart';
import 'package:health_plans/routine/provider/calendar_provider.dart';
import 'package:health_plans/routine/provider/routine_proivder.dart';

class Exercises extends ConsumerStatefulWidget {
  final bool? isRoutine;
  final String part;

  const Exercises({
    this.isRoutine,
    required this.part,
    super.key,
  });

  @override
  ConsumerState<Exercises> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<Exercises> {
  @override
  Widget build(BuildContext context) {
    if (widget.isRoutine != null) {
      return Column(
        // 1. 부위 받아서 부위에 해당하는 운동 검색해서 가져옴
        children: ref.watch(exerciseStreamProvider(part: widget.part)).when(
              data: (exercise) {
                // 2. 운동 가져와서 _renderExerciseCard로 맵핑
                return exercise
                    .map((e) => Container(
                          width: MediaQuery.of(context).size.width,
                          color: black,
                          child: renderExerciseCard(
                            exerciseData: e,
                            isRoutine: widget.isRoutine,
                          ),
                        ))
                    .toList();
              },
              error: (e, s) => [
                const SizedBox(),
              ],
              loading: () => [
                const SizedBox(),
              ],
            ),
      );
    }
    return Column(
      children: ref.watch(exerciseStreamProvider(part: widget.part)).when(
            data: (exercise) {
              return exercise
                  .map((e) => GestureDetector(
                        onTap: () {
                          context.go(
                            "/exercise_screen/update_exercise_screen",
                            extra: e,
                          );
                        },
                        child: Dismissible(
                          key: ObjectKey("$e"),
                          onDismissed: (direction) {
                            ref
                                .read(exerciseNotifierProvider.notifier)
                                .deleteExercisse(id: e.id);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: black,
                            child: renderExerciseCard(exerciseData: e),
                          ),
                        ),
                      ))
                  .toList();
            },
            error: (e, s) => [
              const SizedBox(),
            ],
            loading: () => [
              const SizedBox(),
            ],
          ),
    );
  }

  Widget renderExerciseCard({
    required ExerciseData exerciseData,
    bool? isRoutine,
  }) {
    if (isRoutine != null) {
      // 1. 운동이랑 세트 조절 버튼 가로로 배치
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: ScreenUtilPadding.symmetric(12, 6),
            child: ScreenUtilText(
              exerciseData.exercise,
              size: 18,
            ),
          ),
          SetButton(exerciseData: exerciseData)
        ],
      );
    }

    return Container(
      padding: ScreenUtilPadding.symmetric(12, 6),
      child: ScreenUtilText(
        exerciseData.exercise,
        size: 18,
      ),
    );
  }
}

class SetButton extends HookConsumerWidget {
  final ExerciseData exerciseData;
  const SetButton({
    required this.exerciseData,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final set = useState(0);

    final calendarState = ref.read(calendarProvider);

    // -, 세트 수, + 버튼 가로로  배치
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (set.value > 0) {
              // 변경 사항 저장
              ref.read(routineProvider.notifier).setSet(
                    calendarModel: calendarState,
                    exerciseData: exerciseData,
                    isMinus: true,
                  );
              // 세트 수 마이너스 1
              set.value--;
            }
          },
          child: const Icon(
            Icons.remove,
            color: white,
          ),
        ),
        Padding(
          padding: ScreenUtilPadding.symmetric(6, 0),
          child: ScreenUtilText(
            set.value.toString(),
            size: 18,
          ),
        ),
        GestureDetector(
          onTap: () {
            // 변경 사항 저장
            ref.read(routineProvider.notifier).setSet(
                  calendarModel: calendarState,
                  exerciseData: exerciseData,
                );
            // 세트 수 플러스 1
            set.value++;
          },
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
      ],
    );
  }
}
