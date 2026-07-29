import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/progress_models.dart';

abstract interface class ProgressRepository {
  Stream<UserProgress> watchProgress();
  Future<bool> completeLesson(String lessonId, int xp);
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
  Future<void> revealHint(
    String activityId,
    String activityType,
    int hintsUsed,
  );
  Future<void> viewSolution(String activityId, String activityType);
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
      );
    });
  }

  @override
  Future<bool> completeLesson(String lessonId, int xp) =>
      _database.completeLesson(lessonId, xp);

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
  Future<void> revealHint(
    String activityId,
    String activityType,
    int hintsUsed,
  ) =>
      _database.revealHint(activityId, activityType, hintsUsed);

  @override
  Future<void> viewSolution(String activityId, String activityType) =>
      _database.viewSolution(activityId, activityType);
}

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => DriftProgressRepository(ref.watch(databaseProvider)),
);

final userProgressProvider = StreamProvider<UserProgress>(
  (ref) => ref.watch(progressRepositoryProvider).watchProgress(),
);
