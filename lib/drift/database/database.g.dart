// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  List<GeneratedColumn> get $columns => [id, part, exercise, set];
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
  final String part;
  final String exercise;
  final int set;
  const HealthRoutineData(
      {required this.id,
      required this.part,
      required this.exercise,
      required this.set});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['part'] = Variable<String>(part);
    map['exercise'] = Variable<String>(exercise);
    map['set'] = Variable<int>(set);
    return map;
  }

  HealthRoutineCompanion toCompanion(bool nullToAbsent) {
    return HealthRoutineCompanion(
      id: Value(id),
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
      'part': serializer.toJson<String>(part),
      'exercise': serializer.toJson<String>(exercise),
      'set': serializer.toJson<int>(set),
    };
  }

  HealthRoutineData copyWith(
          {int? id, String? part, String? exercise, int? set}) =>
      HealthRoutineData(
        id: id ?? this.id,
        part: part ?? this.part,
        exercise: exercise ?? this.exercise,
        set: set ?? this.set,
      );
  @override
  String toString() {
    return (StringBuffer('HealthRoutineData(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('exercise: $exercise, ')
          ..write('set: $set')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, part, exercise, set);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthRoutineData &&
          other.id == this.id &&
          other.part == this.part &&
          other.exercise == this.exercise &&
          other.set == this.set);
}

class HealthRoutineCompanion extends UpdateCompanion<HealthRoutineData> {
  final Value<int> id;
  final Value<String> part;
  final Value<String> exercise;
  final Value<int> set;
  const HealthRoutineCompanion({
    this.id = const Value.absent(),
    this.part = const Value.absent(),
    this.exercise = const Value.absent(),
    this.set = const Value.absent(),
  });
  HealthRoutineCompanion.insert({
    this.id = const Value.absent(),
    required String part,
    required String exercise,
    required int set,
  })  : part = Value(part),
        exercise = Value(exercise),
        set = Value(set);
  static Insertable<HealthRoutineData> custom({
    Expression<int>? id,
    Expression<String>? part,
    Expression<String>? exercise,
    Expression<int>? set,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (part != null) 'part': part,
      if (exercise != null) 'exercise': exercise,
      if (set != null) 'set': set,
    });
  }

  HealthRoutineCompanion copyWith(
      {Value<int>? id,
      Value<String>? part,
      Value<String>? exercise,
      Value<int>? set}) {
    return HealthRoutineCompanion(
      id: id ?? this.id,
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
          ..write('part: $part, ')
          ..write('exercise: $exercise, ')
          ..write('set: $set')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $HealthRoutineTable healthRoutine = $HealthRoutineTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [healthRoutine];
}
