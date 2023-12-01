import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_plans/routine/model/calendar_model.dart';

import '../../drift/database/database.dart';

final routineProvider =
    StateNotifierProvider<RoutineStateNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return RoutineStateNotifier(appDatabase: ref.read(databaseProvider));
});

final routineStreamProvider =
    StreamProvider.family<List<HealthRoutineData>, int>((ref, dayId) {
  return ref.read(routineProvider.notifier).watchRoutine(dayId: dayId);
});

class RoutineStateNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final AppDatabase appDatabase;
  RoutineStateNotifier({required this.appDatabase}) : super([]);

  void setSet({
    ExerciseData? exerciseData,
    CalendarModel? calendarModel,
    bool? isMinus,
    String? exercise,
    int? set,
  }) {
    final Map<String, dynamic> routineForm = {
      "date": calendarModel!.selectedDate,
      "dayId": calendarModel.selectedDate.weekday,
      "part": exerciseData?.part ?? "",
      "exercise": exercise ?? exerciseData!.exercise,
      "set": set ?? 0,
    };

    bool isExist = false;
    for (int i = 0; i < state.length; i++) {
      if (state[i]["exercise"] == routineForm["exercise"]) {
        final newState = state;

        newState[i]["set"] = state[i]["set"] + (isMinus != null ? -1 : 1);

        isExist = true;
        break;
      }
    }

    if (!isExist) {
      routineForm["set"] = set ?? 1;

      state.add(routineForm);
    }
  }

  // 루틴 추가 함수
  void addRoutine() async {
    int i = 0;

    final List<HealthRoutineData> routines =
        await getAllRoutine(dayId: state[i]["dayId"]);

    final List<String> exerciseLog = routines.map((e) => e.exercise).toList();

    while (i < state.length) {
      if (state[i]["set"] > 0) {
        if (exerciseLog.contains(state[i]["exercise"]) == false) {
          appDatabase.addRoutine(
            newRoutine: HealthRoutineCompanion.insert(
              date: state[i]["date"],
              dayId: state[i]["dayId"],
              part: state[i]["part"],
              exercise: state[i]["exercise"],
              set: state[i]["set"],
            ),
          );
        }
      }

      i++;
    }

    state = [];
  }

  // 루틴 수정 함수
  void updateRoutine() async {
    int i = 0;

    final List<HealthRoutineData> routines =
        await getAllRoutine(dayId: state[i]["dayId"]);

    final List<String> routineLog =
        routines.map((e) => "${e.exercise}/${e.id}").toList();

    while (i < state.length) {
      if (state[i]["set"] == 0) {
        appDatabase.deleteRoutine(
          id: int.parse(
            routineLog.firstWhere(
              (element) {
                return element.split("/")[0] == state[i]["exercise"];
              },
            ).split("/")[1],
          ),
        );
      } else {
        appDatabase.updateRoutine(
          id: int.parse(
            routineLog.firstWhere(
              (element) {
                return element.split("/")[0] == state[i]["exercise"];
              },
            ).split("/")[1],
          ),
          newRoutine: HealthRoutineCompanion.insert(
            date: state[i]["date"],
            dayId: state[i]["dayId"],
            part: routines.first.part,
            exercise: state[i]["exercise"],
            set: state[i]["set"],
          ),
        );
      }

      i++;
    }
    
    state = [];
  }

  Future<List<HealthRoutineData>> getAllRoutine({required int dayId}) async {
    return await appDatabase.getAllRoutine(dayId: dayId);
  }

  // 루틴 확인 함수
  Stream<List<HealthRoutineData>> watchRoutine({required int dayId}) {
    return appDatabase.watchRoutine(dayId: dayId);
  }
}
