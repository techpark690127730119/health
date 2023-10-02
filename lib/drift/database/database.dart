import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../table/health_routine_table.dart';
part 'database.g.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

@DriftDatabase(tables: [HealthRoutine])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  
  Future<void> addRoutine({required HealthRoutineCompanion data}) =>
      into(healthRoutine).insert(data);

  Stream<List<HealthRoutineData>> watchRoutine({required int dayId}) {
    return (select(healthRoutine)..where((tbl) => tbl.dayId.equals(dayId)))
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
