import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_plans/drift/table/exercise_table.dart';
import 'package:health_plans/drift/table/part_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../table/health_routine_table.dart';

part 'database.g.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

@DriftDatabase(
  tables: [
    Part,
    Exercise,
    HealthRoutine,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 부위 추가
  Future<void> addPart({required PartCompanion newPart}) =>
      into(part).insert(newPart);

  // 부위 업데이트
  Future<void> updatePart({required int id, required PartCompanion newPart}) {
    return (update(part)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(newPart);
  }

  // 부위 삭제
  Future<void> deletePart({required int id}) =>
      (delete(part)..where((tbl) => tbl.id.equals(id))).go();

  // 부위 watch
  Stream<List<PartData>> watchPart() => (select(part)).watch();

  // 운동 추가
  Future<void> addExercise({required ExerciseCompanion newExercise}) =>
      into(exercise).insert(newExercise);

  // 운동 업데이트
  Future<void> updateExercise({
    required int id,
    required ExerciseCompanion newExercise,
  }) {
    return (update(exercise)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(newExercise);
  }

  // 운동 삭제
  Future<void> deleteExercise({required int id}) =>
      (delete(exercise)..where((tbl) => tbl.id.equals(id))).go();

  // 운동 watch
  Stream<List<ExerciseData>> watchExercise({required String part}) {
    return (select(exercise)
          ..where(
            (tbl) => tbl.part.equals(part),
          ))
        .watch();
  }

  // 루틴 추가
  Future<void> addRoutine({required HealthRoutineCompanion newRoutine}) =>
      into(healthRoutine).insert(newRoutine);

  // 루틴 업데이트
  Future<void> updateRoutine({
    required int id,
    required HealthRoutineCompanion newRoutine,
  }) {
    return (update(healthRoutine)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(newRoutine);
  }

  // 루틴 삭제
  Future<void> deleteRoutine({required int id}) =>
      (delete(healthRoutine)..where((tbl) => tbl.id.equals(id))).go();

  // 하나의 루틴 get
  Future<HealthRoutineData> getSingleRoutine({required int id}) {
    return (select(healthRoutine)
          ..where(
            (tbl) => tbl.dayId.equals(id),
          ))
        .getSingle();
  }

  // 모든 루틴 get
  Future<List<HealthRoutineData>> getAllRoutine({required int dayId}) {
    return (select(healthRoutine)
          ..where(
            (tbl) => tbl.dayId.equals(dayId),
          ))
        .get();
  }

  // 루틴 watch
  Stream<List<HealthRoutineData>> watchRoutine({required int dayId}) {
    return (select(healthRoutine)
          ..where(
            (tbl) => tbl.dayId.equals(dayId),
          ))
        .watch();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
