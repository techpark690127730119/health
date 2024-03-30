import 'package:health_plans/exercise/state/exercise_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../drift/database/database.dart';
part 'exercise_provider.g.dart';

@riverpod
Stream<List<PartData>> partStream(PartStreamRef ref) {
  final AppDatabase appDatabase = ref.read(databaseProvider);
  return appDatabase.watchPart();
}

@riverpod
Stream<List<ExerciseData>> exerciseStream(
  ExerciseStreamRef ref, {
  required String part,
}) {
  final AppDatabase appDatabase = ref.read(databaseProvider);
  return appDatabase.watchExercise(part: part);
}

@Riverpod(keepAlive: true)
class ExerciseNotifier extends _$ExerciseNotifier {
  @override
  ExerciseState build() => Initinal();

  // 부위 추가
  Future<bool> addPart({required String newPart}) async {
    try {} catch (e) {}
    try {
      throw UnimplementedError();
      final AppDatabase appDatabase = ref.read(databaseProvider);
      await appDatabase.addPart(
        newPart: PartCompanion.insert(part: newPart),
      );
      return true;
    } catch (e) {
      state = ExerciseError();
      return false;
    }
  }

  // 부위 업데이트
  void updatePart({required int id, required String newPart}) {
    final AppDatabase appDatabase = ref.read(databaseProvider);
    appDatabase.updatePart(
      id: id,
      newPart: PartCompanion.insert(part: newPart),
    );
  }

  // 부위 삭제
  void deletePart({required int id}) {
    final AppDatabase appDatabase = ref.read(databaseProvider);
    appDatabase.deletePart(id: id);
  }

  // 운동 추가
  void addExercise({required String part, required String newExercise}) {
    final AppDatabase appDatabase = ref.read(databaseProvider);
    appDatabase.addExercise(
      newExercise: ExerciseCompanion.insert(
        part: part,
        exercise: newExercise,
      ),
    );
  }

  // 운동 삭제
  void deleteExercisse({required int id}) {
    final AppDatabase appDatabase = ref.read(databaseProvider);
    appDatabase.deleteExercise(id: id);
  }

  // 운동 업데이트
  void updateExercisse(
      {required ExerciseData exerciseData, required String newExercise}) {
    final AppDatabase appDatabase = ref.read(databaseProvider);
    appDatabase.updateExercise(
      id: exerciseData.id,
      newExercise: ExerciseCompanion.insert(
        part: exerciseData.part,
        exercise: newExercise,
      ),
    );
  }
}
