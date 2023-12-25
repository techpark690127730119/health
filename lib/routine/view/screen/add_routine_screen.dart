import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/routine/provider/routine_proivder.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../../exercise/provider/exercise_provider.dart';
import '../../../exercise/view/component/exercise_card.dart';
import '../../../exercise/view/component/part_bar.dart';

class AddRoutineScreen extends ConsumerWidget {
  const AddRoutineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPart = ["가슴", "등", "어깨", "하체", "팔"];

    return DefaultLayout(
      onWillPop: () async {
        ref.read(routineProvider.notifier).reset();
        return true;
      },
      appBar: _renderAppBar(context, ref),
      // 1. 세로로 스크롤 가능하게 배치
      child: ListView(
        children: [
          // 2. 기본 부위 Column으로 맵핑
          // 3. PartBar = 부위 이름 보여줌
          // 4. ExerciseCard = 부위에 해당하는 운동 보여줌
          ...defaultPart
              .map(
                (e) => Column(
                  children: [
                    PartBar(
                      part: e,
                      isRoutine: true,
                    ),
                    Exercises(
                      part: e,
                      isRoutine: true,
                    ),
                  ],
                ),
              )
              .toList(),
          ...ref.watch(partStreamProvider).when(
                data: (data) {
                  return data
                      .map((e) => Column(
                            children: [
                              PartBar(
                                part: e.part,
                                partData: e,
                                isRoutine: true,
                              ),
                              Exercises(
                                part: e.part,
                                isRoutine: true,
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
        ],
      ),
    );
  }

  PreferredSizeWidget _renderAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ScreenUtilText(
            "루틴 추가",
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () {
              ref.read(routineProvider.notifier).addRoutine();
              context.pop();
            },
            child: const ScreenUtilText(
              "완료",
              color: red,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
