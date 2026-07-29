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

class ActivityCompletions extends Table {
  TextColumn get activityId => text()();
  TextColumn get activityType => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get xpEarned => integer()();

  @override
  Set<Column<Object>> get primaryKey => {activityId, activityType};
}

class ActivityStates extends Table {
  TextColumn get activityId => text()();
  TextColumn get activityType => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();
  BoolColumn get solutionViewed =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {activityId, activityType};
}

@DriftDatabase(
  tables: [
    ProgressEntries,
    CompletedLessons,
    LearningSessions,
    CodeSnippets,
    ActivityCompletions,
    ActivityStates,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'javapath'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) => migrator.createAll(),
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(activityCompletions);
          }
          if (from < 3) {
            await migrator.createTable(activityStates);
          }
        },
      );

  Future<int> readProgressValue(String key) async {
    final row = await (select(progressEntries)
          ..where((entry) => entry.key.equals(key)))
        .getSingleOrNull();
    return row?.value ?? 0;
  }

  Stream<List<CompletedLesson>> watchCompletedLessons() =>
      select(completedLessons).watch();

  Stream<List<ProgressEntry>> watchProgressEntries() =>
      select(progressEntries).watch();

  Future<void> _incrementProgress(String key, int amount) async {
    final current = await readProgressValue(key);
    await into(progressEntries).insertOnConflictUpdate(
      ProgressEntriesCompanion.insert(
        key: key,
        value: Value(current + amount),
      ),
    );
  }

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
      await _incrementProgress('xp', xp);
      await _incrementProgress('completed_lessons', 1);
      return true;
    });
  }

  Future<bool> completeActivity({
    required String activityId,
    required String activityType,
    required int xp,
  }) {
    return transaction(() async {
      final existing = await (select(activityCompletions)
            ..where(
              (activity) =>
                  activity.activityId.equals(activityId) &
                  activity.activityType.equals(activityType),
            ))
          .getSingleOrNull();
      if (existing != null) return false;

      await into(activityCompletions).insert(
        ActivityCompletionsCompanion.insert(
          activityId: activityId,
          activityType: activityType,
          completedAt: DateTime.now(),
          xpEarned: xp,
        ),
      );
      await _incrementProgress('xp', xp);
      final counterKey = switch (activityType) {
        'exercise' => 'completed_exercises',
        'quiz' => 'completed_quiz_questions',
        'debug' => 'completed_challenges',
        'prediction' => 'completed_predictions',
        _ => 'completed_activities',
      };
      await _incrementProgress(counterKey, 1);
      return true;
    });
  }

  Future<ActivityState?> readActivityState(
    String activityId,
    String activityType,
  ) {
    return (select(activityStates)
          ..where(
            (activity) =>
                activity.activityId.equals(activityId) &
                activity.activityType.equals(activityType),
          ))
        .getSingleOrNull();
  }

  Future<void> recordAttempt(String activityId, String activityType) async {
    final state = await readActivityState(activityId, activityType);
    await into(activityStates).insertOnConflictUpdate(
      ActivityStatesCompanion.insert(
        activityId: activityId,
        activityType: activityType,
        attempts: Value((state?.attempts ?? 0) + 1),
        hintsUsed: Value(state?.hintsUsed ?? 0),
        solutionViewed: Value(state?.solutionViewed ?? false),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> revealHint(
    String activityId,
    String activityType,
    int hintsUsed,
  ) async {
    final state = await readActivityState(activityId, activityType);
    await into(activityStates).insertOnConflictUpdate(
      ActivityStatesCompanion.insert(
        activityId: activityId,
        activityType: activityType,
        attempts: Value(state?.attempts ?? 0),
        hintsUsed: Value(hintsUsed),
        solutionViewed: Value(state?.solutionViewed ?? false),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> viewSolution(String activityId, String activityType) async {
    final state = await readActivityState(activityId, activityType);
    await into(activityStates).insertOnConflictUpdate(
      ActivityStatesCompanion.insert(
        activityId: activityId,
        activityType: activityType,
        attempts: Value(state?.attempts ?? 0),
        hintsUsed: Value(state?.hintsUsed ?? 0),
        solutionViewed: const Value(true),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
