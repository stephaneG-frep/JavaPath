import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/progress/domain/achievement_service.dart';
import 'package:java_path/features/progress/domain/progress_models.dart';

void main() {
  test('débloque les badges correspondant à la progression', () {
    const progress = UserProgress(
      xp: 520,
      completedLessons: 1,
      completedExercises: 1,
      completedProjects: 0,
      currentStreak: 2,
      completedQuizQuestions: 1,
    );

    final badges = AchievementService.evaluate(progress);

    expect(
      badges.firstWhere((badge) => badge.id == 'hello-java').isUnlocked,
      isTrue,
    );
    expect(
      badges.firstWhere((badge) => badge.id == 'java-apprentice').isUnlocked,
      isTrue,
    );
    expect(
      badges.firstWhere((badge) => badge.id == 'project-builder').isUnlocked,
      isFalse,
    );
  });
}
