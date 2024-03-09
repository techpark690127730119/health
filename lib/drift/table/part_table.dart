import 'package:drift/drift.dart';

class Part extends Table {
  // 키
  IntColumn get id => integer().autoIncrement()();

  // 부위
  TextColumn get part => text().withLength(
        min: 1,
        max: 30,
      )();
}
