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

class ExerciseCard extends ConsumerStatefulWidget {
  final bool? isRoutine;
  final String part;

  const ExerciseCard({
    this.isRoutine,
    required this.part,
    super.key,
  });

  @override
  ConsumerState<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<ExerciseCard> {
  int set = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.isRoutine != null) {
      return Column(
        children: ref.watch(exerciseStreamProvider(widget.part)).when(
              data: (exercise) {
                return exercise
                    .map((e) => Container(
                          width: MediaQuery.of(context).size.width,
                          color: black,
                          child: _renderExerciseCard(
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
      children: ref.watch(exerciseStreamProvider(widget.part)).when(
            data: (exercise) {
              return exercise
                  .map((e) => GestureDetector(
                        onTap: () {
                          ref.read(exerciseProvider.notifier).selectExercise(
                                part: widget.part,
                                exercise: e,
                              );
                          context.go("/exercise_screen/update_exercise_screen");
                        },
                        child: Dismissible(
                          key: ObjectKey("$e"),
                          onDismissed: (direction) {
                            ref
                                .read(exerciseProvider.notifier)
                                .deleteExercisse(id: e.id);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: black,
                            child: _renderExerciseCard(exerciseData: e),
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

  Widget _renderExerciseCard({
    required ExerciseData exerciseData,
    bool? isRoutine,
  }) {
    if (isRoutine != null) {
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
          _renderSetButton(exerciseData: exerciseData)
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

  Widget _renderSetButton({required ExerciseData exerciseData}) {
    final calendarState = ref.read(calendarProvider);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            ref.read(routineProvider.notifier).setSet(
                calendarModel: calendarState,
                exerciseData: exerciseData,
                isMinus: true);
            if (set > 0) {
              setState(() {
                set--;
              });
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
            set.toString(),
            size: 18,
          ),
        ),
        GestureDetector(
          onTap: () {
            ref.read(routineProvider.notifier).setSet(
                  calendarModel: calendarState,
                  exerciseData: exerciseData,
                );
            setState(() {
              set++;
            });
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
