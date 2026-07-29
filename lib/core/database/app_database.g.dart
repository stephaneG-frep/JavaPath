// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProgressEntriesTable extends ProgressEntries
    with TableInfo<$ProgressEntriesTable, ProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  ProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $ProgressEntriesTable createAlias(String alias) {
    return $ProgressEntriesTable(attachedDatabase, alias);
  }
}

class ProgressEntry extends DataClass implements Insertable<ProgressEntry> {
  final String key;
  final int value;
  const ProgressEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<int>(value);
    return map;
  }

  ProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return ProgressEntriesCompanion(key: Value(key), value: Value(value));
  }

  factory ProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<int>(value),
    };
  }

  ProgressEntry copyWith({String? key, int? value}) =>
      ProgressEntry(key: key ?? this.key, value: value ?? this.value);
  ProgressEntry copyWithCompanion(ProgressEntriesCompanion data) {
    return ProgressEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class ProgressEntriesCompanion extends UpdateCompanion<ProgressEntry> {
  final Value<String> key;
  final Value<int> value;
  final Value<int> rowid;
  const ProgressEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgressEntriesCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<ProgressEntry> custom({
    Expression<String>? key,
    Expression<int>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgressEntriesCompanion copyWith({
    Value<String>? key,
    Value<int>? value,
    Value<int>? rowid,
  }) {
    return ProgressEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompletedLessonsTable extends CompletedLessons
    with TableInfo<$CompletedLessonsTable, CompletedLesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletedLessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [lessonId, completedAt, xpEarned];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completed_lessons';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletedLesson> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    } else if (isInserting) {
      context.missing(_xpEarnedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lessonId};
  @override
  CompletedLesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedLesson(
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
    );
  }

  @override
  $CompletedLessonsTable createAlias(String alias) {
    return $CompletedLessonsTable(attachedDatabase, alias);
  }
}

class CompletedLesson extends DataClass implements Insertable<CompletedLesson> {
  final String lessonId;
  final DateTime completedAt;
  final int xpEarned;
  const CompletedLesson({
    required this.lessonId,
    required this.completedAt,
    required this.xpEarned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lesson_id'] = Variable<String>(lessonId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['xp_earned'] = Variable<int>(xpEarned);
    return map;
  }

  CompletedLessonsCompanion toCompanion(bool nullToAbsent) {
    return CompletedLessonsCompanion(
      lessonId: Value(lessonId),
      completedAt: Value(completedAt),
      xpEarned: Value(xpEarned),
    );
  }

  factory CompletedLesson.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletedLesson(
      lessonId: serializer.fromJson<String>(json['lessonId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lessonId': serializer.toJson<String>(lessonId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'xpEarned': serializer.toJson<int>(xpEarned),
    };
  }

  CompletedLesson copyWith({
    String? lessonId,
    DateTime? completedAt,
    int? xpEarned,
  }) => CompletedLesson(
    lessonId: lessonId ?? this.lessonId,
    completedAt: completedAt ?? this.completedAt,
    xpEarned: xpEarned ?? this.xpEarned,
  );
  CompletedLesson copyWithCompanion(CompletedLessonsCompanion data) {
    return CompletedLesson(
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletedLesson(')
          ..write('lessonId: $lessonId, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lessonId, completedAt, xpEarned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedLesson &&
          other.lessonId == this.lessonId &&
          other.completedAt == this.completedAt &&
          other.xpEarned == this.xpEarned);
}

class CompletedLessonsCompanion extends UpdateCompanion<CompletedLesson> {
  final Value<String> lessonId;
  final Value<DateTime> completedAt;
  final Value<int> xpEarned;
  final Value<int> rowid;
  const CompletedLessonsCompanion({
    this.lessonId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletedLessonsCompanion.insert({
    required String lessonId,
    required DateTime completedAt,
    required int xpEarned,
    this.rowid = const Value.absent(),
  }) : lessonId = Value(lessonId),
       completedAt = Value(completedAt),
       xpEarned = Value(xpEarned);
  static Insertable<CompletedLesson> custom({
    Expression<String>? lessonId,
    Expression<DateTime>? completedAt,
    Expression<int>? xpEarned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lessonId != null) 'lesson_id': lessonId,
      if (completedAt != null) 'completed_at': completedAt,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletedLessonsCompanion copyWith({
    Value<String>? lessonId,
    Value<DateTime>? completedAt,
    Value<int>? xpEarned,
    Value<int>? rowid,
  }) {
    return CompletedLessonsCompanion(
      lessonId: lessonId ?? this.lessonId,
      completedAt: completedAt ?? this.completedAt,
      xpEarned: xpEarned ?? this.xpEarned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletedLessonsCompanion(')
          ..write('lessonId: $lessonId, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningSessionsTable extends LearningSessions
    with TableInfo<$LearningSessionsTable, LearningSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    durationMinutes,
    lessonId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      ),
    );
  }

  @override
  $LearningSessionsTable createAlias(String alias) {
    return $LearningSessionsTable(attachedDatabase, alias);
  }
}

class LearningSession extends DataClass implements Insertable<LearningSession> {
  final int id;
  final DateTime startedAt;
  final int durationMinutes;
  final String? lessonId;
  const LearningSession({
    required this.id,
    required this.startedAt,
    required this.durationMinutes,
    this.lessonId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || lessonId != null) {
      map['lesson_id'] = Variable<String>(lessonId);
    }
    return map;
  }

  LearningSessionsCompanion toCompanion(bool nullToAbsent) {
    return LearningSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      durationMinutes: Value(durationMinutes),
      lessonId: lessonId == null && nullToAbsent
          ? const Value.absent()
          : Value(lessonId),
    );
  }

  factory LearningSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningSession(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      lessonId: serializer.fromJson<String?>(json['lessonId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'lessonId': serializer.toJson<String?>(lessonId),
    };
  }

  LearningSession copyWith({
    int? id,
    DateTime? startedAt,
    int? durationMinutes,
    Value<String?> lessonId = const Value.absent(),
  }) => LearningSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    lessonId: lessonId.present ? lessonId.value : this.lessonId,
  );
  LearningSession copyWithCompanion(LearningSessionsCompanion data) {
    return LearningSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('lessonId: $lessonId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startedAt, durationMinutes, lessonId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.lessonId == this.lessonId);
}

class LearningSessionsCompanion extends UpdateCompanion<LearningSession> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<int> durationMinutes;
  final Value<String?> lessonId;
  const LearningSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.lessonId = const Value.absent(),
  });
  LearningSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    required int durationMinutes,
    this.lessonId = const Value.absent(),
  }) : startedAt = Value(startedAt),
       durationMinutes = Value(durationMinutes);
  static Insertable<LearningSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<int>? durationMinutes,
    Expression<String>? lessonId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (lessonId != null) 'lesson_id': lessonId,
    });
  }

  LearningSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<int>? durationMinutes,
    Value<String?>? lessonId,
  }) {
    return LearningSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      lessonId: lessonId ?? this.lessonId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('lessonId: $lessonId')
          ..write(')'))
        .toString();
  }
}

class $CodeSnippetsTable extends CodeSnippets
    with TableInfo<$CodeSnippetsTable, CodeSnippet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CodeSnippetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    code,
    updatedAt,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'code_snippets';
  @override
  VerificationContext validateIntegrity(
    Insertable<CodeSnippet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CodeSnippet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CodeSnippet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $CodeSnippetsTable createAlias(String alias) {
    return $CodeSnippetsTable(attachedDatabase, alias);
  }
}

class CodeSnippet extends DataClass implements Insertable<CodeSnippet> {
  final int id;
  final String title;
  final String code;
  final DateTime updatedAt;
  final bool isFavorite;
  const CodeSnippet({
    required this.id,
    required this.title,
    required this.code,
    required this.updatedAt,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['code'] = Variable<String>(code);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  CodeSnippetsCompanion toCompanion(bool nullToAbsent) {
    return CodeSnippetsCompanion(
      id: Value(id),
      title: Value(title),
      code: Value(code),
      updatedAt: Value(updatedAt),
      isFavorite: Value(isFavorite),
    );
  }

  factory CodeSnippet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CodeSnippet(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      code: serializer.fromJson<String>(json['code']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'code': serializer.toJson<String>(code),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  CodeSnippet copyWith({
    int? id,
    String? title,
    String? code,
    DateTime? updatedAt,
    bool? isFavorite,
  }) => CodeSnippet(
    id: id ?? this.id,
    title: title ?? this.title,
    code: code ?? this.code,
    updatedAt: updatedAt ?? this.updatedAt,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  CodeSnippet copyWithCompanion(CodeSnippetsCompanion data) {
    return CodeSnippet(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      code: data.code.present ? data.code.value : this.code,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CodeSnippet(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('code: $code, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, code, updatedAt, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CodeSnippet &&
          other.id == this.id &&
          other.title == this.title &&
          other.code == this.code &&
          other.updatedAt == this.updatedAt &&
          other.isFavorite == this.isFavorite);
}

class CodeSnippetsCompanion extends UpdateCompanion<CodeSnippet> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> code;
  final Value<DateTime> updatedAt;
  final Value<bool> isFavorite;
  const CodeSnippetsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.code = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  CodeSnippetsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String code,
    required DateTime updatedAt,
    this.isFavorite = const Value.absent(),
  }) : title = Value(title),
       code = Value(code),
       updatedAt = Value(updatedAt);
  static Insertable<CodeSnippet> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? code,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (code != null) 'code': code,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  CodeSnippetsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? code,
    Value<DateTime>? updatedAt,
    Value<bool>? isFavorite,
  }) {
    return CodeSnippetsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      code: code ?? this.code,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CodeSnippetsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('code: $code, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $ActivityCompletionsTable extends ActivityCompletions
    with TableInfo<$ActivityCompletionsTable, ActivityCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    activityId,
    activityType,
    completedAt,
    xpEarned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    } else if (isInserting) {
      context.missing(_xpEarnedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {activityId, activityType};
  @override
  ActivityCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityCompletion(
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      activityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_type'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
    );
  }

  @override
  $ActivityCompletionsTable createAlias(String alias) {
    return $ActivityCompletionsTable(attachedDatabase, alias);
  }
}

class ActivityCompletion extends DataClass
    implements Insertable<ActivityCompletion> {
  final String activityId;
  final String activityType;
  final DateTime completedAt;
  final int xpEarned;
  const ActivityCompletion({
    required this.activityId,
    required this.activityType,
    required this.completedAt,
    required this.xpEarned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['activity_id'] = Variable<String>(activityId);
    map['activity_type'] = Variable<String>(activityType);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['xp_earned'] = Variable<int>(xpEarned);
    return map;
  }

  ActivityCompletionsCompanion toCompanion(bool nullToAbsent) {
    return ActivityCompletionsCompanion(
      activityId: Value(activityId),
      activityType: Value(activityType),
      completedAt: Value(completedAt),
      xpEarned: Value(xpEarned),
    );
  }

  factory ActivityCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityCompletion(
      activityId: serializer.fromJson<String>(json['activityId']),
      activityType: serializer.fromJson<String>(json['activityType']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'activityId': serializer.toJson<String>(activityId),
      'activityType': serializer.toJson<String>(activityType),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'xpEarned': serializer.toJson<int>(xpEarned),
    };
  }

  ActivityCompletion copyWith({
    String? activityId,
    String? activityType,
    DateTime? completedAt,
    int? xpEarned,
  }) => ActivityCompletion(
    activityId: activityId ?? this.activityId,
    activityType: activityType ?? this.activityType,
    completedAt: completedAt ?? this.completedAt,
    xpEarned: xpEarned ?? this.xpEarned,
  );
  ActivityCompletion copyWithCompanion(ActivityCompletionsCompanion data) {
    return ActivityCompletion(
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      activityType: data.activityType.present
          ? data.activityType.value
          : this.activityType,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityCompletion(')
          ..write('activityId: $activityId, ')
          ..write('activityType: $activityType, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(activityId, activityType, completedAt, xpEarned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityCompletion &&
          other.activityId == this.activityId &&
          other.activityType == this.activityType &&
          other.completedAt == this.completedAt &&
          other.xpEarned == this.xpEarned);
}

class ActivityCompletionsCompanion extends UpdateCompanion<ActivityCompletion> {
  final Value<String> activityId;
  final Value<String> activityType;
  final Value<DateTime> completedAt;
  final Value<int> xpEarned;
  final Value<int> rowid;
  const ActivityCompletionsCompanion({
    this.activityId = const Value.absent(),
    this.activityType = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityCompletionsCompanion.insert({
    required String activityId,
    required String activityType,
    required DateTime completedAt,
    required int xpEarned,
    this.rowid = const Value.absent(),
  }) : activityId = Value(activityId),
       activityType = Value(activityType),
       completedAt = Value(completedAt),
       xpEarned = Value(xpEarned);
  static Insertable<ActivityCompletion> custom({
    Expression<String>? activityId,
    Expression<String>? activityType,
    Expression<DateTime>? completedAt,
    Expression<int>? xpEarned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (activityId != null) 'activity_id': activityId,
      if (activityType != null) 'activity_type': activityType,
      if (completedAt != null) 'completed_at': completedAt,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityCompletionsCompanion copyWith({
    Value<String>? activityId,
    Value<String>? activityType,
    Value<DateTime>? completedAt,
    Value<int>? xpEarned,
    Value<int>? rowid,
  }) {
    return ActivityCompletionsCompanion(
      activityId: activityId ?? this.activityId,
      activityType: activityType ?? this.activityType,
      completedAt: completedAt ?? this.completedAt,
      xpEarned: xpEarned ?? this.xpEarned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityCompletionsCompanion(')
          ..write('activityId: $activityId, ')
          ..write('activityType: $activityType, ')
          ..write('completedAt: $completedAt, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityStatesTable extends ActivityStates
    with TableInfo<$ActivityStatesTable, ActivityState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hintsUsedMeta = const VerificationMeta(
    'hintsUsed',
  );
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
    'hints_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _solutionViewedMeta = const VerificationMeta(
    'solutionViewed',
  );
  @override
  late final GeneratedColumn<bool> solutionViewed = GeneratedColumn<bool>(
    'solution_viewed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("solution_viewed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    activityId,
    activityType,
    attempts,
    hintsUsed,
    solutionViewed,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('hints_used')) {
      context.handle(
        _hintsUsedMeta,
        hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta),
      );
    }
    if (data.containsKey('solution_viewed')) {
      context.handle(
        _solutionViewedMeta,
        solutionViewed.isAcceptableOrUnknown(
          data['solution_viewed']!,
          _solutionViewedMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {activityId, activityType};
  @override
  ActivityState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityState(
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      activityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_type'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      hintsUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_used'],
      )!,
      solutionViewed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}solution_viewed'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ActivityStatesTable createAlias(String alias) {
    return $ActivityStatesTable(attachedDatabase, alias);
  }
}

class ActivityState extends DataClass implements Insertable<ActivityState> {
  final String activityId;
  final String activityType;
  final int attempts;
  final int hintsUsed;
  final bool solutionViewed;
  final DateTime updatedAt;
  const ActivityState({
    required this.activityId,
    required this.activityType,
    required this.attempts,
    required this.hintsUsed,
    required this.solutionViewed,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['activity_id'] = Variable<String>(activityId);
    map['activity_type'] = Variable<String>(activityType);
    map['attempts'] = Variable<int>(attempts);
    map['hints_used'] = Variable<int>(hintsUsed);
    map['solution_viewed'] = Variable<bool>(solutionViewed);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ActivityStatesCompanion toCompanion(bool nullToAbsent) {
    return ActivityStatesCompanion(
      activityId: Value(activityId),
      activityType: Value(activityType),
      attempts: Value(attempts),
      hintsUsed: Value(hintsUsed),
      solutionViewed: Value(solutionViewed),
      updatedAt: Value(updatedAt),
    );
  }

  factory ActivityState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityState(
      activityId: serializer.fromJson<String>(json['activityId']),
      activityType: serializer.fromJson<String>(json['activityType']),
      attempts: serializer.fromJson<int>(json['attempts']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      solutionViewed: serializer.fromJson<bool>(json['solutionViewed']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'activityId': serializer.toJson<String>(activityId),
      'activityType': serializer.toJson<String>(activityType),
      'attempts': serializer.toJson<int>(attempts),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'solutionViewed': serializer.toJson<bool>(solutionViewed),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ActivityState copyWith({
    String? activityId,
    String? activityType,
    int? attempts,
    int? hintsUsed,
    bool? solutionViewed,
    DateTime? updatedAt,
  }) => ActivityState(
    activityId: activityId ?? this.activityId,
    activityType: activityType ?? this.activityType,
    attempts: attempts ?? this.attempts,
    hintsUsed: hintsUsed ?? this.hintsUsed,
    solutionViewed: solutionViewed ?? this.solutionViewed,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ActivityState copyWithCompanion(ActivityStatesCompanion data) {
    return ActivityState(
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      activityType: data.activityType.present
          ? data.activityType.value
          : this.activityType,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      solutionViewed: data.solutionViewed.present
          ? data.solutionViewed.value
          : this.solutionViewed,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityState(')
          ..write('activityId: $activityId, ')
          ..write('activityType: $activityType, ')
          ..write('attempts: $attempts, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('solutionViewed: $solutionViewed, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    activityId,
    activityType,
    attempts,
    hintsUsed,
    solutionViewed,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityState &&
          other.activityId == this.activityId &&
          other.activityType == this.activityType &&
          other.attempts == this.attempts &&
          other.hintsUsed == this.hintsUsed &&
          other.solutionViewed == this.solutionViewed &&
          other.updatedAt == this.updatedAt);
}

class ActivityStatesCompanion extends UpdateCompanion<ActivityState> {
  final Value<String> activityId;
  final Value<String> activityType;
  final Value<int> attempts;
  final Value<int> hintsUsed;
  final Value<bool> solutionViewed;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ActivityStatesCompanion({
    this.activityId = const Value.absent(),
    this.activityType = const Value.absent(),
    this.attempts = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.solutionViewed = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityStatesCompanion.insert({
    required String activityId,
    required String activityType,
    this.attempts = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.solutionViewed = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : activityId = Value(activityId),
       activityType = Value(activityType),
       updatedAt = Value(updatedAt);
  static Insertable<ActivityState> custom({
    Expression<String>? activityId,
    Expression<String>? activityType,
    Expression<int>? attempts,
    Expression<int>? hintsUsed,
    Expression<bool>? solutionViewed,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (activityId != null) 'activity_id': activityId,
      if (activityType != null) 'activity_type': activityType,
      if (attempts != null) 'attempts': attempts,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (solutionViewed != null) 'solution_viewed': solutionViewed,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityStatesCompanion copyWith({
    Value<String>? activityId,
    Value<String>? activityType,
    Value<int>? attempts,
    Value<int>? hintsUsed,
    Value<bool>? solutionViewed,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ActivityStatesCompanion(
      activityId: activityId ?? this.activityId,
      activityType: activityType ?? this.activityType,
      attempts: attempts ?? this.attempts,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      solutionViewed: solutionViewed ?? this.solutionViewed,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (solutionViewed.present) {
      map['solution_viewed'] = Variable<bool>(solutionViewed.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityStatesCompanion(')
          ..write('activityId: $activityId, ')
          ..write('activityType: $activityType, ')
          ..write('attempts: $attempts, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('solutionViewed: $solutionViewed, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProgressEntriesTable progressEntries = $ProgressEntriesTable(
    this,
  );
  late final $CompletedLessonsTable completedLessons = $CompletedLessonsTable(
    this,
  );
  late final $LearningSessionsTable learningSessions = $LearningSessionsTable(
    this,
  );
  late final $CodeSnippetsTable codeSnippets = $CodeSnippetsTable(this);
  late final $ActivityCompletionsTable activityCompletions =
      $ActivityCompletionsTable(this);
  late final $ActivityStatesTable activityStates = $ActivityStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    progressEntries,
    completedLessons,
    learningSessions,
    codeSnippets,
    activityCompletions,
    activityStates,
  ];
}

typedef $$ProgressEntriesTableCreateCompanionBuilder =
    ProgressEntriesCompanion Function({
      required String key,
      Value<int> value,
      Value<int> rowid,
    });
typedef $$ProgressEntriesTableUpdateCompanionBuilder =
    ProgressEntriesCompanion Function({
      Value<String> key,
      Value<int> value,
      Value<int> rowid,
    });

class $$ProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$ProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressEntriesTable,
          ProgressEntry,
          $$ProgressEntriesTableFilterComposer,
          $$ProgressEntriesTableOrderingComposer,
          $$ProgressEntriesTableAnnotationComposer,
          $$ProgressEntriesTableCreateCompanionBuilder,
          $$ProgressEntriesTableUpdateCompanionBuilder,
          (
            ProgressEntry,
            BaseReferences<_$AppDatabase, $ProgressEntriesTable, ProgressEntry>,
          ),
          ProgressEntry,
          PrefetchHooks Function()
        > {
  $$ProgressEntriesTableTableManager(
    _$AppDatabase db,
    $ProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressEntriesCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<int> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressEntriesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressEntriesTable,
      ProgressEntry,
      $$ProgressEntriesTableFilterComposer,
      $$ProgressEntriesTableOrderingComposer,
      $$ProgressEntriesTableAnnotationComposer,
      $$ProgressEntriesTableCreateCompanionBuilder,
      $$ProgressEntriesTableUpdateCompanionBuilder,
      (
        ProgressEntry,
        BaseReferences<_$AppDatabase, $ProgressEntriesTable, ProgressEntry>,
      ),
      ProgressEntry,
      PrefetchHooks Function()
    >;
typedef $$CompletedLessonsTableCreateCompanionBuilder =
    CompletedLessonsCompanion Function({
      required String lessonId,
      required DateTime completedAt,
      required int xpEarned,
      Value<int> rowid,
    });
typedef $$CompletedLessonsTableUpdateCompanionBuilder =
    CompletedLessonsCompanion Function({
      Value<String> lessonId,
      Value<DateTime> completedAt,
      Value<int> xpEarned,
      Value<int> rowid,
    });

class $$CompletedLessonsTableFilterComposer
    extends Composer<_$AppDatabase, $CompletedLessonsTable> {
  $$CompletedLessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompletedLessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompletedLessonsTable> {
  $$CompletedLessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompletedLessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletedLessonsTable> {
  $$CompletedLessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);
}

class $$CompletedLessonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompletedLessonsTable,
          CompletedLesson,
          $$CompletedLessonsTableFilterComposer,
          $$CompletedLessonsTableOrderingComposer,
          $$CompletedLessonsTableAnnotationComposer,
          $$CompletedLessonsTableCreateCompanionBuilder,
          $$CompletedLessonsTableUpdateCompanionBuilder,
          (
            CompletedLesson,
            BaseReferences<
              _$AppDatabase,
              $CompletedLessonsTable,
              CompletedLesson
            >,
          ),
          CompletedLesson,
          PrefetchHooks Function()
        > {
  $$CompletedLessonsTableTableManager(
    _$AppDatabase db,
    $CompletedLessonsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletedLessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletedLessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletedLessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> lessonId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletedLessonsCompanion(
                lessonId: lessonId,
                completedAt: completedAt,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lessonId,
                required DateTime completedAt,
                required int xpEarned,
                Value<int> rowid = const Value.absent(),
              }) => CompletedLessonsCompanion.insert(
                lessonId: lessonId,
                completedAt: completedAt,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompletedLessonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompletedLessonsTable,
      CompletedLesson,
      $$CompletedLessonsTableFilterComposer,
      $$CompletedLessonsTableOrderingComposer,
      $$CompletedLessonsTableAnnotationComposer,
      $$CompletedLessonsTableCreateCompanionBuilder,
      $$CompletedLessonsTableUpdateCompanionBuilder,
      (
        CompletedLesson,
        BaseReferences<_$AppDatabase, $CompletedLessonsTable, CompletedLesson>,
      ),
      CompletedLesson,
      PrefetchHooks Function()
    >;
typedef $$LearningSessionsTableCreateCompanionBuilder =
    LearningSessionsCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      required int durationMinutes,
      Value<String?> lessonId,
    });
typedef $$LearningSessionsTableUpdateCompanionBuilder =
    LearningSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<int> durationMinutes,
      Value<String?> lessonId,
    });

class $$LearningSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearningSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);
}

class $$LearningSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningSessionsTable,
          LearningSession,
          $$LearningSessionsTableFilterComposer,
          $$LearningSessionsTableOrderingComposer,
          $$LearningSessionsTableAnnotationComposer,
          $$LearningSessionsTableCreateCompanionBuilder,
          $$LearningSessionsTableUpdateCompanionBuilder,
          (
            LearningSession,
            BaseReferences<
              _$AppDatabase,
              $LearningSessionsTable,
              LearningSession
            >,
          ),
          LearningSession,
          PrefetchHooks Function()
        > {
  $$LearningSessionsTableTableManager(
    _$AppDatabase db,
    $LearningSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String?> lessonId = const Value.absent(),
              }) => LearningSessionsCompanion(
                id: id,
                startedAt: startedAt,
                durationMinutes: durationMinutes,
                lessonId: lessonId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                required int durationMinutes,
                Value<String?> lessonId = const Value.absent(),
              }) => LearningSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                durationMinutes: durationMinutes,
                lessonId: lessonId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningSessionsTable,
      LearningSession,
      $$LearningSessionsTableFilterComposer,
      $$LearningSessionsTableOrderingComposer,
      $$LearningSessionsTableAnnotationComposer,
      $$LearningSessionsTableCreateCompanionBuilder,
      $$LearningSessionsTableUpdateCompanionBuilder,
      (
        LearningSession,
        BaseReferences<_$AppDatabase, $LearningSessionsTable, LearningSession>,
      ),
      LearningSession,
      PrefetchHooks Function()
    >;
typedef $$CodeSnippetsTableCreateCompanionBuilder =
    CodeSnippetsCompanion Function({
      Value<int> id,
      required String title,
      required String code,
      required DateTime updatedAt,
      Value<bool> isFavorite,
    });
typedef $$CodeSnippetsTableUpdateCompanionBuilder =
    CodeSnippetsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> code,
      Value<DateTime> updatedAt,
      Value<bool> isFavorite,
    });

class $$CodeSnippetsTableFilterComposer
    extends Composer<_$AppDatabase, $CodeSnippetsTable> {
  $$CodeSnippetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CodeSnippetsTableOrderingComposer
    extends Composer<_$AppDatabase, $CodeSnippetsTable> {
  $$CodeSnippetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CodeSnippetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CodeSnippetsTable> {
  $$CodeSnippetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$CodeSnippetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CodeSnippetsTable,
          CodeSnippet,
          $$CodeSnippetsTableFilterComposer,
          $$CodeSnippetsTableOrderingComposer,
          $$CodeSnippetsTableAnnotationComposer,
          $$CodeSnippetsTableCreateCompanionBuilder,
          $$CodeSnippetsTableUpdateCompanionBuilder,
          (
            CodeSnippet,
            BaseReferences<_$AppDatabase, $CodeSnippetsTable, CodeSnippet>,
          ),
          CodeSnippet,
          PrefetchHooks Function()
        > {
  $$CodeSnippetsTableTableManager(_$AppDatabase db, $CodeSnippetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CodeSnippetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CodeSnippetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CodeSnippetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => CodeSnippetsCompanion(
                id: id,
                title: title,
                code: code,
                updatedAt: updatedAt,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String code,
                required DateTime updatedAt,
                Value<bool> isFavorite = const Value.absent(),
              }) => CodeSnippetsCompanion.insert(
                id: id,
                title: title,
                code: code,
                updatedAt: updatedAt,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CodeSnippetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CodeSnippetsTable,
      CodeSnippet,
      $$CodeSnippetsTableFilterComposer,
      $$CodeSnippetsTableOrderingComposer,
      $$CodeSnippetsTableAnnotationComposer,
      $$CodeSnippetsTableCreateCompanionBuilder,
      $$CodeSnippetsTableUpdateCompanionBuilder,
      (
        CodeSnippet,
        BaseReferences<_$AppDatabase, $CodeSnippetsTable, CodeSnippet>,
      ),
      CodeSnippet,
      PrefetchHooks Function()
    >;
typedef $$ActivityCompletionsTableCreateCompanionBuilder =
    ActivityCompletionsCompanion Function({
      required String activityId,
      required String activityType,
      required DateTime completedAt,
      required int xpEarned,
      Value<int> rowid,
    });
typedef $$ActivityCompletionsTableUpdateCompanionBuilder =
    ActivityCompletionsCompanion Function({
      Value<String> activityId,
      Value<String> activityType,
      Value<DateTime> completedAt,
      Value<int> xpEarned,
      Value<int> rowid,
    });

class $$ActivityCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityCompletionsTable> {
  $$ActivityCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityCompletionsTable> {
  $$ActivityCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityCompletionsTable> {
  $$ActivityCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);
}

class $$ActivityCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityCompletionsTable,
          ActivityCompletion,
          $$ActivityCompletionsTableFilterComposer,
          $$ActivityCompletionsTableOrderingComposer,
          $$ActivityCompletionsTableAnnotationComposer,
          $$ActivityCompletionsTableCreateCompanionBuilder,
          $$ActivityCompletionsTableUpdateCompanionBuilder,
          (
            ActivityCompletion,
            BaseReferences<
              _$AppDatabase,
              $ActivityCompletionsTable,
              ActivityCompletion
            >,
          ),
          ActivityCompletion,
          PrefetchHooks Function()
        > {
  $$ActivityCompletionsTableTableManager(
    _$AppDatabase db,
    $ActivityCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityCompletionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ActivityCompletionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> activityId = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityCompletionsCompanion(
                activityId: activityId,
                activityType: activityType,
                completedAt: completedAt,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String activityId,
                required String activityType,
                required DateTime completedAt,
                required int xpEarned,
                Value<int> rowid = const Value.absent(),
              }) => ActivityCompletionsCompanion.insert(
                activityId: activityId,
                activityType: activityType,
                completedAt: completedAt,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityCompletionsTable,
      ActivityCompletion,
      $$ActivityCompletionsTableFilterComposer,
      $$ActivityCompletionsTableOrderingComposer,
      $$ActivityCompletionsTableAnnotationComposer,
      $$ActivityCompletionsTableCreateCompanionBuilder,
      $$ActivityCompletionsTableUpdateCompanionBuilder,
      (
        ActivityCompletion,
        BaseReferences<
          _$AppDatabase,
          $ActivityCompletionsTable,
          ActivityCompletion
        >,
      ),
      ActivityCompletion,
      PrefetchHooks Function()
    >;
typedef $$ActivityStatesTableCreateCompanionBuilder =
    ActivityStatesCompanion Function({
      required String activityId,
      required String activityType,
      Value<int> attempts,
      Value<int> hintsUsed,
      Value<bool> solutionViewed,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ActivityStatesTableUpdateCompanionBuilder =
    ActivityStatesCompanion Function({
      Value<String> activityId,
      Value<String> activityType,
      Value<int> attempts,
      Value<int> hintsUsed,
      Value<bool> solutionViewed,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ActivityStatesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityStatesTable> {
  $$ActivityStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get solutionViewed => $composableBuilder(
    column: $table.solutionViewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityStatesTable> {
  $$ActivityStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get solutionViewed => $composableBuilder(
    column: $table.solutionViewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityStatesTable> {
  $$ActivityStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<bool> get solutionViewed => $composableBuilder(
    column: $table.solutionViewed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ActivityStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityStatesTable,
          ActivityState,
          $$ActivityStatesTableFilterComposer,
          $$ActivityStatesTableOrderingComposer,
          $$ActivityStatesTableAnnotationComposer,
          $$ActivityStatesTableCreateCompanionBuilder,
          $$ActivityStatesTableUpdateCompanionBuilder,
          (
            ActivityState,
            BaseReferences<_$AppDatabase, $ActivityStatesTable, ActivityState>,
          ),
          ActivityState,
          PrefetchHooks Function()
        > {
  $$ActivityStatesTableTableManager(
    _$AppDatabase db,
    $ActivityStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> activityId = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<bool> solutionViewed = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityStatesCompanion(
                activityId: activityId,
                activityType: activityType,
                attempts: attempts,
                hintsUsed: hintsUsed,
                solutionViewed: solutionViewed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String activityId,
                required String activityType,
                Value<int> attempts = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<bool> solutionViewed = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ActivityStatesCompanion.insert(
                activityId: activityId,
                activityType: activityType,
                attempts: attempts,
                hintsUsed: hintsUsed,
                solutionViewed: solutionViewed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityStatesTable,
      ActivityState,
      $$ActivityStatesTableFilterComposer,
      $$ActivityStatesTableOrderingComposer,
      $$ActivityStatesTableAnnotationComposer,
      $$ActivityStatesTableCreateCompanionBuilder,
      $$ActivityStatesTableUpdateCompanionBuilder,
      (
        ActivityState,
        BaseReferences<_$AppDatabase, $ActivityStatesTable, ActivityState>,
      ),
      ActivityState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProgressEntriesTableTableManager get progressEntries =>
      $$ProgressEntriesTableTableManager(_db, _db.progressEntries);
  $$CompletedLessonsTableTableManager get completedLessons =>
      $$CompletedLessonsTableTableManager(_db, _db.completedLessons);
  $$LearningSessionsTableTableManager get learningSessions =>
      $$LearningSessionsTableTableManager(_db, _db.learningSessions);
  $$CodeSnippetsTableTableManager get codeSnippets =>
      $$CodeSnippetsTableTableManager(_db, _db.codeSnippets);
  $$ActivityCompletionsTableTableManager get activityCompletions =>
      $$ActivityCompletionsTableTableManager(_db, _db.activityCompletions);
  $$ActivityStatesTableTableManager get activityStates =>
      $$ActivityStatesTableTableManager(_db, _db.activityStates);
}
