import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class ProgressEntries extends Table {
  TextColumn get key => text()();
  IntColumn get value => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class CompletedLessons extends Table {
  TextColumn get lessonId => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get xpEarned => integer()();

  @override
  Set<Column<Object>> get primaryKey => {lessonId};
}

class LearningSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  IntColumn get durationMinutes => integer()();
  TextColumn get lessonId => text().nullable()();
}

class CodeSnippets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get code => text()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(
  tables: [ProgressEntries, CompletedLessons, LearningSessions, CodeSnippets],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'javapath'));

  @override
  int get schemaVersion => 1;

  Future<int> readProgressValue(String key) async {
    final row = await (select(progressEntries)
          ..where((entry) => entry.key.equals(key)))
        .getSingleOrNull();
    return row?.value ?? 0;
  }

  Stream<List<CompletedLesson>> watchCompletedLessons() =>
      select(completedLessons).watch();

  Future<bool> completeLesson(String lessonId, int xp) {
    return transaction(() async {
      final existing = await (select(completedLessons)
            ..where((lesson) => lesson.lessonId.equals(lessonId)))
          .getSingleOrNull();
      if (existing != null) return false;

      await into(completedLessons).insert(
        CompletedLessonsCompanion.insert(
          lessonId: lessonId,
          completedAt: DateTime.now(),
          xpEarned: xp,
        ),
      );
      final currentXp = await readProgressValue('xp');
      await into(progressEntries).insertOnConflictUpdate(
        ProgressEntriesCompanion.insert(
          key: 'xp',
          value: Value(currentXp + xp),
        ),
      );
      return true;
    });
  }
}
