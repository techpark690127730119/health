import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../drift/database/database.dart';

final exerciseProvider =
    StateNotifierProvider<ExerciseStateNotifier, Object?>((ref) {
  return ExerciseStateNotifier(appDatabase: ref.read(databaseProvider));
});

final exerciseStreamProvider =
    StreamProvider.family<List<ExerciseData>, String>((ref, part) {
  return ref.watch(exerciseProvider.notifier).watchExercise(part: part);
});

final partStreamProvider = StreamProvider<List<PartData>>((ref) {
  return ref.watch(exerciseProvider.notifier).watchPart();
});

class ExerciseStateNotifier extends StateNotifier<Object?> {
  final AppDatabase appDatabase;
  ExerciseStateNotifier({required this.appDatabase}) : super(null);

  // 부위 추가
  void addPart({
    required String newPart,
  }) {
    appDatabase.addPart(
      newPart: PartCompanion.insert(
        part: newPart,
      ),
    );
  }

  // 부위 업데이트
  void updatePart({
    required int id,
    required String newPart,
  }) {
    appDatabase.updatePart(
      id: id,
      newPart: PartCompanion.insert(
        part: newPart,
      ),
    );
  }

  // 부위 삭제
  void deletePart({
    required int id,
  }) {
    appDatabase.deletePart(id: id);
  }

  // 부위 watch
  Stream<List<PartData>> watchPart() {
    return appDatabase.watchPart();
  }

  // 운동 추가
  void addExercise({
    required String part,
    required String newExercise,
  }) {
    appDatabase.addExercise(
      newExercise: ExerciseCompanion.insert(
        part: part,
        exercise: newExercise,
      ),
    );
  }

  // 운동 삭제
  void deleteExercisse({
    required int id,
  }) {
    appDatabase.deleteExercise(id: id);
  }

  // 운동 업데이트
  void updateExercisse({
    required ExerciseData exerciseData,
    required String newExercise,
  }) {
    appDatabase.updateExercise(
      id: exerciseData.id,
      newExercise: ExerciseCompanion.insert(
        part: exerciseData.part,
        exercise: newExercise,
      ),
    );
  }

  // 운동 watch
  Stream<List<ExerciseData>> watchExercise({
    required String part,
  }) {
    return appDatabase.watchExercise(part: part);
  }
}
