import 'package:drift/drift.dart';

class HealthRoutine extends Table {
  //키
  IntColumn get id => integer().autoIncrement()();
  //날짜
  DateTimeColumn get date => dateTime()();
  //요일
  IntColumn get dayId => integer()();
  //부위
  TextColumn get part => text().withLength(min: 1, max: 30)();
  //운동
  TextColumn get exercise => text().withLength(min: 1, max: 30)();
  //세트
  IntColumn get set => integer()();
}
