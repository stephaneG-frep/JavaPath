import 'progress_models.dart';

class AchievementStatus {
  const AchievementStatus({
    required this.id,
    required this.title,
    required this.description,
    required this.iconKey,
    required this.current,
    required this.target,
  });

  final String id;
  final String title;
  final String description;
  final String iconKey;
  final int current;
  final int target;

  bool get isUnlocked => current >= target;
  double get progress => (current / target).clamp(0, 1);
}

abstract final class AchievementService {
  static List<AchievementStatus> evaluate(UserProgress progress) {
    return [
      AchievementStatus(
        id: 'hello-java',
        title: 'Hello Java',
        description: 'Terminer sa première leçon.',
        iconKey: 'code',
        current: progress.completedLessons,
        target: 1,
      ),
      AchievementStatus(
        id: 'quiz-starter',
        title: 'Premier quiz',
        description: 'Réussir une première question de quiz.',
        iconKey: 'quiz',
        current: progress.completedQuizQuestions,
        target: 1,
      ),
      AchievementStatus(
        id: 'practice-starter',
        title: 'Passage à la pratique',
        description: 'Valider son premier exercice.',
        iconKey: 'exercise',
        current: progress.completedExercises,
        target: 1,
      ),
      AchievementStatus(
        id: 'bug-hunter',
        title: 'Bug Hunter',
        description: 'Résoudre les 5 Debug Challenges.',
        iconKey: 'bug',
        current: progress.completedChallenges,
        target: 5,
      ),
      AchievementStatus(
        id: 'project-builder',
        title: 'Project Builder',
        description: 'Terminer un projet guidé.',
        iconKey: 'project',
        current: progress.completedProjects,
        target: 1,
      ),
      AchievementStatus(
        id: 'seven-day-streak',
        title: '7 Day Streak',
        description: 'Apprendre pendant 7 jours.',
        iconKey: 'streak',
        current: progress.currentStreak,
        target: 7,
      ),
      AchievementStatus(
        id: 'java-apprentice',
        title: 'Java Apprentice',
        description: 'Atteindre 500 XP.',
        iconKey: 'xp',
        current: progress.xp,
        target: 500,
      ),
      AchievementStatus(
        id: 'foundation-complete',
        title: 'Fondamentaux terminés',
        description: 'Terminer les 10 premières leçons.',
        iconKey: 'school',
        current: progress.completedLessons,
        target: 10,
      ),
      AchievementStatus(
        id: 'object-master',
        title: 'Object Master',
        description: 'Terminer le niveau Programmation orientée objet.',
        iconKey: 'object',
        current: progress.completedLessons,
        target: 27,
      ),
    ];
  }
}
