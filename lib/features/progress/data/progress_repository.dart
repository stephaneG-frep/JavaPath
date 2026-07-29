import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/progress_models.dart';

abstract interface class ProgressRepository {
  Stream<UserProgress> watchProgress();
  Future<bool> completeLesson(String lessonId, int xp, int minutes);
  Future<bool> completeActivity({
    required String activityId,
    required String activityType,
    required int xp,
  });
  Future<ActivityProgressState> readActivityState(
    String activityId,
    String activityType,
  );
  Future<void> recordAttempt(String activityId, String activityType);
  Future<void> recordCorrectAnswer();
  Future<void> revealHint(
    String activityId,
    String activityType,
    int hintsUsed,
  );
  Future<void> viewSolution(String activityId, String activityType);
  Stream<Set<String>> watchCompletedActivityIds(String activityType);
  Stream<List<ConceptReview>> watchReviews();
  Future<void> recordReviewError(String conceptId);
  Future<void> recordReviewSuccess(String conceptId);
}

class DriftProgressRepository implements ProgressRepository {
  const DriftProgressRepository(this._database);
  final AppDatabase _database;

  @override
  Stream<UserProgress> watchProgress() {
    return _database.watchProgressEntries().map((entries) {
      final values = {for (final entry in entries) entry.key: entry.value};
      return UserProgress(
        xp: values['xp'] ?? 0,
        completedLessons: values['completed_lessons'] ?? 0,
        completedExercises: values['completed_exercises'] ?? 0,
        completedProjects: values['completed_projects'] ?? 0,
        currentStreak: values['current_streak'] ?? 0,
        completedChallenges: values['completed_challenges'] ?? 0,
        completedPredictions: values['completed_predictions'] ?? 0,
        completedQuizQuestions: values['completed_quiz_questions'] ?? 0,
        bestStreak: values['best_streak'] ?? 0,
        streakProtections: values['streak_protections'] ?? 1,
        learningMinutes: values['learning_minutes'] ?? 0,
        totalAttempts: values['total_attempts'] ?? 0,
        correctAnswers: values['correct_answers'] ?? 0,
        startedDay: values['started_day'] ?? 0,
      );
    });
  }

  @override
  Future<bool> completeLesson(String lessonId, int xp, int minutes) =>
      _database.completeLesson(lessonId, xp, minutes);

  @override
  Future<bool> completeActivity({
    required String activityId,
    required String activityType,
    required int xp,
  }) =>
      _database.completeActivity(
        activityId: activityId,
        activityType: activityType,
        xp: xp,
      );

  @override
  Future<ActivityProgressState> readActivityState(
    String activityId,
    String activityType,
  ) async {
    final state = await _database.readActivityState(activityId, activityType);
    if (state == null) return ActivityProgressState.empty;
    return ActivityProgressState(
      attempts: state.attempts,
      hintsUsed: state.hintsUsed,
      solutionViewed: state.solutionViewed,
    );
  }

  @override
  Future<void> recordAttempt(String activityId, String activityType) =>
      _database.recordAttempt(activityId, activityType);

  @override
  Future<void> recordCorrectAnswer() => _database.recordCorrectAnswer();

  @override
  Future<void> revealHint(
    String activityId,
    String activityType,
    int hintsUsed,
  ) =>
      _database.revealHint(activityId, activityType, hintsUsed);

  @override
  Future<void> viewSolution(String activityId, String activityType) =>
      _database.viewSolution(activityId, activityType);

  @override
  Stream<Set<String>> watchCompletedActivityIds(String activityType) =>
      _database.watchCompletedActivityIds(activityType);

  @override
  Stream<List<ConceptReview>> watchReviews() {
    return _database.watchReviewRecords().map(
          (rows) => rows
              .map(
                (row) => ConceptReview(
                  conceptId: row.conceptId,
                  errorCount: row.errorCount,
                  successCount: row.successCount,
                  nextReviewDay: row.nextReviewDay,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> recordReviewError(String conceptId) =>
      _database.recordReviewError(conceptId);

  @override
  Future<void> recordReviewSuccess(String conceptId) =>
      _database.recordReviewSuccess(conceptId);
}

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => DriftProgressRepository(ref.watch(databaseProvider)),
);

final userProgressProvider = StreamProvider<UserProgress>(
  (ref) => ref.watch(progressRepositoryProvider).watchProgress(),
);

final completedActivityIdsProvider =
    StreamProvider.family<Set<String>, String>((ref, activityType) {
  return ref
      .watch(progressRepositoryProvider)
      .watchCompletedActivityIds(activityType);
});

final conceptReviewsProvider = StreamProvider<List<ConceptReview>>(
  (ref) => ref.watch(progressRepositoryProvider).watchReviews(),
);
