import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/progress_models.dart';

abstract interface class ProgressRepository {
  Stream<UserProgress> watchProgress();
  Future<bool> completeLesson(String lessonId, int xp);
}

class DriftProgressRepository implements ProgressRepository {
  const DriftProgressRepository(this._database);
  final AppDatabase _database;

  @override
  Stream<UserProgress> watchProgress() {
    return _database.watchCompletedLessons().asyncMap((lessons) async {
      final xp = await _database.readProgressValue('xp');
      return UserProgress(
        xp: xp,
        completedLessons: lessons.length,
        completedExercises:
            await _database.readProgressValue('completed_exercises'),
        completedProjects:
            await _database.readProgressValue('completed_projects'),
        currentStreak: await _database.readProgressValue('current_streak'),
      );
    });
  }

  @override
  Future<bool> completeLesson(String lessonId, int xp) =>
      _database.completeLesson(lessonId, xp);
}

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => DriftProgressRepository(ref.watch(databaseProvider)),
);

final userProgressProvider = StreamProvider<UserProgress>(
  (ref) => ref.watch(progressRepositoryProvider).watchProgress(),
);
