import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/progress/domain/progress_models.dart';

void main() {
  group('calcul des niveaux', () {
    test('commence au niveau 1 avec 0 XP', () {
      const progress = UserProgress(
        xp: 0,
        completedLessons: 0,
        completedExercises: 0,
        completedProjects: 0,
        currentStreak: 0,
      );

      expect(progress.level, 1);
      expect(progress.nextLevelXp, 100);
      expect(progress.levelProgress, 0);
    });

    test('passe au niveau suivant au seuil exact', () {
      expect(UserProgress.levelForXp(99), 1);
      expect(UserProgress.levelForXp(100), 2);
      expect(UserProgress.levelForXp(300), 3);
    });
  });

  test('le titre de progression évolue avec le niveau', () {
    expect(UserProgress.rankForLevel(1), 'Java Rookie');
    expect(UserProgress.rankForLevel(5), 'Java Apprentice');
    expect(UserProgress.rankForLevel(10), 'Java Developer');
    expect(UserProgress.rankForLevel(20), 'Java Expert');
    expect(UserProgress.rankForLevel(30), 'Java Master');
  });
}
