import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/common/layout/default_layout.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/routine/provider/routine_proivder.dart';
import '../../../common/const/colors.dart';
import '../../../common/view/component/screen_util_padding.dart';
import '../../../common/view/component/screen_util_text.dart';
import '../../provider/calendar_provider.dart';

class UpdateRoutineScreen extends ConsumerWidget {
  const UpdateRoutineScreen({super.key});

  Future<List<HealthRoutineData>> getAllRoutines({
    required WidgetRef ref,
  }) async {
    return await ref
        .read(routineProvider.notifier)
        .getAllRoutine(dayId: ref.read(calendarProvider).selectedDate.weekday);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      onWillPop: () async {
        ref.read(routineProvider.notifier).reset();
        return true;
      },
      appBar: _renderAppBar(context: context, ref: ref),
      child: FutureBuilder(
        future: getAllRoutines(ref: ref),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            );
          }

          final List<HealthRoutineData> data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final HealthRoutineData routine = data[index];

              final int initialSet = routine.set;

              return _Routines(
                initialSet: initialSet,
                exercise: routine.exercise,
              );
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _renderAppBar({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScreenUtilText(
            ref.read(calendarProvider.notifier).selectedDay(
                  selectedDate: ref.read(calendarProvider).selectedDate,
                ),
            size: 24,
            weight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: () {
              ref.read(routineProvider.notifier).updateRoutine();
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

class _Routines extends ConsumerStatefulWidget {
  final int initialSet;

  final String exercise;

  const _Routines({
    required this.initialSet,
    required this.exercise,
  });

  @override
  ConsumerState<_Routines> createState() => __RoutinesState();
}

class __RoutinesState extends ConsumerState<_Routines> {
  late int set;

  @override
  void initState() {
    set = widget.initialSet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ScreenUtilPadding.symmetric(0, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScreenUtilText(
            widget.exercise,
            size: 18,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (set > 0) {
                    setState(() {
                      set--;
                      ref.read(routineProvider.notifier).setSet(
                            exercise: widget.exercise,
                            calendarModel: ref.read(calendarProvider),
                            set: set,
                            isMinus: true,
                          );
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
                  setState(() {
                    set++;
                    ref.read(routineProvider.notifier).setSet(
                          exercise: widget.exercise,
                          calendarModel: ref.read(calendarProvider),
                          set: set,
                        );
                  });
                },
                child: const Icon(
                  Icons.add,
                  color: white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
