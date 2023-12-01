import 'package:drift/drift.dart';

class Exercise extends Table {
  // 키
  IntColumn get id => integer().autoIncrement()();

  // 부위
  TextColumn get part => text().withLength(min: 1, max: 30)();

  // 운동
  TextColumn get exercise => text().withLength(min: 1, max: 30)();
}
