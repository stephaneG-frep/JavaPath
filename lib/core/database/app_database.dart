import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../services/review_policy.dart';
import '../services/streak_calculator.dart';

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

class ExecutionHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get output => text()();
  TextColumn get status => text()();
  DateTimeColumn get executedAt => dateTime()();
}

class ReviewRecords extends Table {
  TextColumn get conceptId => text()();
  IntColumn get errorCount => integer().withDefault(const Constant(0))();
  IntColumn get successCount => integer().withDefault(const Constant(0))();
  IntColumn get nextReviewDay => integer()();
  IntColumn get lastReviewDay => integer()();

  @override
  Set<Column<Object>> get primaryKey => {conceptId};
}

@DriftDatabase(
  tables: [
    ProgressEntries,
    CompletedLessons,
    LearningSessions,
    CodeSnippets,
    ActivityCompletions,
    ActivityStates,
    ExecutionHistories,
    ReviewRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'javapath'));

  @override
  int get schemaVersion => 5;

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
          if (from < 4) {
            await migrator.createTable(executionHistories);
          }
          if (from < 5) {
            await migrator.createTable(reviewRecords);
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

  Stream<Set<String>> watchCompletedActivityIds(String activityType) {
    return (select(activityCompletions)
          ..where((activity) => activity.activityType.equals(activityType)))
        .watch()
        .map((rows) => rows.map((row) => row.activityId).toSet());
  }

  Future<void> _incrementProgress(String key, int amount) async {
    final current = await readProgressValue(key);
    await into(progressEntries).insertOnConflictUpdate(
      ProgressEntriesCompanion.insert(
        key: key,
        value: Value(current + amount),
      ),
    );
  }

  Future<void> _setProgress(String key, int value) {
    return into(progressEntries).insertOnConflictUpdate(
      ProgressEntriesCompanion.insert(key: key, value: Value(value)),
    );
  }

  int _dayNumber([DateTime? date]) {
    final value = date ?? DateTime.now();
    return DateTime.utc(value.year, value.month, value.day)
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerDay;
  }

  Future<void> _recordLearningActivity(int minutes) async {
    final today = _dayNumber();
    final storedLastDay = await readProgressValue('last_activity_day');
    final lastDay = storedLastDay == 0 ? null : storedLastDay;
    final current = await readProgressValue('current_streak');
    final best = await readProgressValue('best_streak');
    final protectionRow = await (select(progressEntries)
          ..where((entry) => entry.key.equals('streak_protections')))
        .getSingleOrNull();
    final protections = protectionRow?.value ?? 1;
    final update = StreakCalculator.calculate(
      lastActivityDay: lastDay,
      today: today,
      current: current,
      best: best,
      protections: protections,
    );
    await _setProgress('last_activity_day', today);
    await _setProgress('current_streak', update.current);
    await _setProgress('best_streak', update.best);
    await _setProgress('streak_protections', update.protections);
    if (await readProgressValue('started_day') == 0) {
      await _setProgress('started_day', today);
    }
    await _incrementProgress('learning_minutes', minutes);
  }

  Future<bool> completeLesson(String lessonId, int xp, int minutes) {
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
      await _recordLearningActivity(minutes);
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
        'project' => 'completed_projects',
        _ => null,
      };
      if (counterKey != null) await _incrementProgress(counterKey, 1);
      final minutes = switch (activityType) {
        'quiz' => 2,
        'exercise' => 5,
        'debug' => 5,
        'prediction' => 4,
        'project_mission' => 15,
        _ => 0,
      };
      if (minutes > 0) await _recordLearningActivity(minutes);
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
    await _incrementProgress('total_attempts', 1);
  }

  Future<void> recordCorrectAnswer() =>
      _incrementProgress('correct_answers', 1);

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

  Stream<List<CodeSnippet>> watchCodeSnippets() {
    return (select(codeSnippets)
          ..orderBy([
            (snippet) => OrderingTerm.desc(snippet.isFavorite),
            (snippet) => OrderingTerm.desc(snippet.updatedAt),
          ]))
        .watch();
  }

  Future<int> saveCodeSnippet(String title, String code) {
    return into(codeSnippets).insert(
      CodeSnippetsCompanion.insert(
        title: title,
        code: code,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> toggleSnippetFavorite(int id, bool isFavorite) {
    return (update(codeSnippets)..where((snippet) => snippet.id.equals(id)))
        .write(
      CodeSnippetsCompanion(
        isFavorite: Value(isFavorite),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<List<ExecutionHistory>> watchExecutionHistory() {
    return (select(executionHistories)
          ..orderBy([
            (entry) => OrderingTerm.desc(entry.executedAt),
          ])
          ..limit(50))
        .watch();
  }

  Future<int> recordExecution({
    required String code,
    required String output,
    required String status,
  }) {
    return into(executionHistories).insert(
      ExecutionHistoriesCompanion.insert(
        code: code,
        output: output,
        status: status,
        executedAt: DateTime.now(),
      ),
    );
  }

  Stream<List<ReviewRecord>> watchReviewRecords() {
    return (select(reviewRecords)
          ..orderBy([
            (record) => OrderingTerm.asc(record.nextReviewDay),
            (record) => OrderingTerm.desc(record.errorCount),
          ]))
        .watch();
  }

  Future<void> recordReviewError(String conceptId) async {
    final today = _dayNumber();
    final current = await (select(reviewRecords)
          ..where((record) => record.conceptId.equals(conceptId)))
        .getSingleOrNull();
    await into(reviewRecords).insertOnConflictUpdate(
      ReviewRecordsCompanion.insert(
        conceptId: conceptId,
        errorCount: Value((current?.errorCount ?? 0) + 1),
        successCount: Value(current?.successCount ?? 0),
        nextReviewDay: today,
        lastReviewDay: today,
      ),
    );
  }

  Future<void> recordReviewSuccess(String conceptId) async {
    final today = _dayNumber();
    final current = await (select(reviewRecords)
          ..where((record) => record.conceptId.equals(conceptId)))
        .getSingleOrNull();
    if (current == null) return;
    final successes = current.successCount + 1;
    await into(reviewRecords).insertOnConflictUpdate(
      ReviewRecordsCompanion.insert(
        conceptId: conceptId,
        errorCount: Value(current.errorCount),
        successCount: Value(successes),
        nextReviewDay: today + ReviewPolicy.intervalDays(successes),
        lastReviewDay: today,
      ),
    );
  }
}
