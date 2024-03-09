// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PartTable extends Part with TableInfo<$PartTable, PartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<String> part = GeneratedColumn<String>(
      'part', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, part];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part';
  @override
  VerificationContext validateIntegrity(Insertable<PartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part'])!,
    );
  }

  @override
  $PartTable createAlias(String alias) {
    return $PartTable(attachedDatabase, alias);
  }
}

class PartData extends DataClass implements Insertable<PartData> {
  final int id;
  final String part;
  const PartData({required this.id, required this.part});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['part'] = Variable<String>(part);
    return map;
  }

  PartCompanion toCompanion(bool nullToAbsent) {
    return PartCompanion(
      id: Value(id),
      part: Value(part),
    );
  }

  factory PartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartData(
      id: serializer.fromJson<int>(json['id']),
      part: serializer.fromJson<String>(json['part']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'part': serializer.toJson<String>(part),
    };
  }

  PartData copyWith({int? id, String? part}) => PartData(
        id: id ?? this.id,
        part: part ?? this.part,
      );
  @override
  String toString() {
    return (StringBuffer('PartData(')
          ..write('id: $id, ')
          ..write('part: $part')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, part);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartData && other.id == this.id && other.part == this.part);
}

class PartCompanion extends UpdateCompanion<PartData> {
  final Value<int> id;
  final Value<String> part;
  const PartCompanion({
    this.id = const Value.absent(),
    this.part = const Value.absent(),
  });
  PartCompanion.insert({
    this.id = const Value.absent(),
    required String part,
  }) : part = Value(part);
  static Insertable<PartData> custom({
    Expression<int>? id,
    Expression<String>? part,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (part != null) 'part': part,
    });
  }

  PartCompanion copyWith({Value<int>? id, Value<String>? part}) {
    return PartCompanion(
      id: id ?? this.id,
      part: part ?? this.part,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (part.present) {
      map['part'] = Variable<String>(part.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartCompanion(')
          ..write('id: $id, ')
          ..write('part: $part')
          ..write(')'))
        .toString();
  }
}

class $ExerciseTable extends Exercise
    with TableInfo<$ExerciseTable, ExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<String> part = GeneratedColumn<String>(
      'part', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _exerciseMeta =
      const VerificationMeta('exercise');
  @override
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
      'exercise', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, part, exercise];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(_exerciseMeta,
          exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta));
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part'])!,
      exercise: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise'])!,
    );
  }

  @override
  $ExerciseTable createAlias(String alias) {
    return $ExerciseTable(attachedDatabase, alias);
  }
}

class ExerciseData extends DataClass implements Insertable<ExerciseData> {
  final int id;
  final String part;
  final String exercise;
  const ExerciseData(
      {required this.id, required this.part, required this.exercise});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['part'] = Variable<String>(part);
    map['exercise'] = Variable<String>(exercise);
    return map;
  }

  ExerciseCompanion toCompanion(bool nullToAbsent) {
    return ExerciseCompanion(
      id: Value(id),
      part: Value(part),
      exercise: Value(exercise),
    );
  }

  factory ExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseData(
      id: serializer.fromJson<int>(json['id']),
      part: serializer.fromJson<String>(json['part']),
      exercise: serializer.fromJson<String>(json['exercise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'part': serializer.toJson<String>(part),
      'exercise': serializer.toJson<String>(exercise),
    };
  }

  ExerciseData copyWith({int? id, String? part, String? exercise}) =>
      ExerciseData(
        id: id ?? this.id,
        part: part ?? this.part,
        exercise: exercise ?? this.exercise,
      );
  @override
  String toString() {
    return (StringBuffer('ExerciseData(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('exercise: $exercise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, part, exercise);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseData &&
          other.id == this.id &&
          other.part == this.part &&
          other.exercise == this.exercise);
}

class ExerciseCompanion extends UpdateCompanion<ExerciseData> {
  final Value<int> id;
  final Value<String> part;
  final Value<String> exercise;
  const ExerciseCompanion({
    this.id = const Value.absent(),
    this.part = const Value.absent(),
    this.exercise = const Value.absent(),
  });
  ExerciseCompanion.insert({
    this.id = const Value.absent(),
    required String part,
    required String exercise,
  })  : part = Value(part),
        exercise = Value(exercise);
  static Insertable<ExerciseData> custom({
    Expression<int>? id,
    Expression<String>? part,
    Expression<String>? exercise,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (part != null) 'part': part,
      if (exercise != null) 'exercise': exercise,
    });
  }

  ExerciseCompanion copyWith(
      {Value<int>? id, Value<String>? part, Value<String>? exercise}) {
    return ExerciseCompanion(
      id: id ?? this.id,
      part: part ?? this.part,
      exercise: exercise ?? this.exercise,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (part.present) {
      map['part'] = Variable<String>(part.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCompanion(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('exercise: $exercise')
          ..write(')'))
        .toString();
  }
}

class $HealthRoutineTable extends HealthRoutine
    with TableInfo<$HealthRoutineTable, HealthRoutineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthRoutineTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
      'day_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<String> part = GeneratedColumn<String>(
      'part', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _exerciseMeta =
      const VerificationMeta('exercise');
  @override
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
      'exercise', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _setMeta = const VerificationMeta('set');
  @override
  late final GeneratedColumn<int> set = GeneratedColumn<int>(
      'set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, dayId, part, exercise, set];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_routine';
  @override
  VerificationContext validateIntegrity(Insertable<HealthRoutineData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(_exerciseMeta,
          exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta));
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('set')) {
      context.handle(
          _setMeta, set.isAcceptableOrUnknown(data['set']!, _setMeta));
    } else if (isInserting) {
      context.missing(_setMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthRoutineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthRoutineData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_id'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part'])!,
      exercise: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise'])!,
      set: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set'])!,
    );
  }

  @override
  $HealthRoutineTable createAlias(String alias) {
    return $HealthRoutineTable(attachedDatabase, alias);
  }
}

class HealthRoutineData extends DataClass
    implements Insertable<HealthRoutineData> {
  final int id;
  final DateTime date;
  final int dayId;
  final String part;
  final String exercise;
  final int set;
  const HealthRoutineData(
      {required this.id,
      required this.date,
      required this.dayId,
      required this.part,
      required this.exercise,
      required this.set});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['day_id'] = Variable<int>(dayId);
    map['part'] = Variable<String>(part);
    map['exercise'] = Variable<String>(exercise);
    map['set'] = Variable<int>(set);
    return map;
  }

  HealthRoutineCompanion toCompanion(bool nullToAbsent) {
    return HealthRoutineCompanion(
      id: Value(id),
      date: Value(date),
      dayId: Value(dayId),
      part: Value(part),
      exercise: Value(exercise),
      set: Value(set),
    );
  }

  factory HealthRoutineData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthRoutineData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      dayId: serializer.fromJson<int>(json['dayId']),
      part: serializer.fromJson<String>(json['part']),
      exercise: serializer.fromJson<String>(json['exercise']),
      set: serializer.fromJson<int>(json['set']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'dayId': serializer.toJson<int>(dayId),
      'part': serializer.toJson<String>(part),
      'exercise': serializer.toJson<String>(exercise),
      'set': serializer.toJson<int>(set),
    };
  }

  HealthRoutineData copyWith(
          {int? id,
          DateTime? date,
          int? dayId,
          String? part,
          String? exercise,
          int? set}) =>
      HealthRoutineData(
        id: id ?? this.id,
        date: date ?? this.date,
        dayId: dayId ?? this.dayId,
        part: part ?? this.part,
        exercise: exercise ?? this.exercise,
        set: set ?? this.set,
      );
  @override
  String toString() {
    return (StringBuffer('HealthRoutineData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dayId: $dayId, ')
          ..write('part: $part, ')
          ..write('exercise: $exercise, ')
          ..write('set: $set')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, dayId, part, exercise, set);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthRoutineData &&
          other.id == this.id &&
          other.date == this.date &&
          other.dayId == this.dayId &&
          other.part == this.part &&
          other.exercise == this.exercise &&
          other.set == this.set);
}

class HealthRoutineCompanion extends UpdateCompanion<HealthRoutineData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> dayId;
  final Value<String> part;
  final Value<String> exercise;
  final Value<int> set;
  const HealthRoutineCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.dayId = const Value.absent(),
    this.part = const Value.absent(),
    this.exercise = const Value.absent(),
    this.set = const Value.absent(),
  });
  HealthRoutineCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int dayId,
    required String part,
    required String exercise,
    required int set,
  })  : date = Value(date),
        dayId = Value(dayId),
        part = Value(part),
        exercise = Value(exercise),
        set = Value(set);
  static Insertable<HealthRoutineData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? dayId,
    Expression<String>? part,
    Expression<String>? exercise,
    Expression<int>? set,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (dayId != null) 'day_id': dayId,
      if (part != null) 'part': part,
      if (exercise != null) 'exercise': exercise,
      if (set != null) 'set': set,
    });
  }

  HealthRoutineCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? dayId,
      Value<String>? part,
      Value<String>? exercise,
      Value<int>? set}) {
    return HealthRoutineCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      dayId: dayId ?? this.dayId,
      part: part ?? this.part,
      exercise: exercise ?? this.exercise,
      set: set ?? this.set,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<int>(dayId.value);
    }
    if (part.present) {
      map['part'] = Variable<String>(part.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (set.present) {
      map['set'] = Variable<int>(set.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthRoutineCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dayId: $dayId, ')
          ..write('part: $part, ')
          ..write('exercise: $exercise, ')
          ..write('set: $set')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PartTable part = $PartTable(this);
  late final $ExerciseTable exercise = $ExerciseTable(this);
  late final $HealthRoutineTable healthRoutine = $HealthRoutineTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [part, exercise, healthRoutine];
}
