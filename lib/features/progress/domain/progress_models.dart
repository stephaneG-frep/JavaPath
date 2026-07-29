class UserProgress {
  const UserProgress({
    required this.xp,
    required this.completedLessons,
    required this.completedExercises,
    required this.completedProjects,
    required this.currentStreak,
    this.completedChallenges = 0,
    this.completedPredictions = 0,
    this.completedQuizQuestions = 0,
    this.bestStreak = 0,
    this.streakProtections = 1,
    this.learningMinutes = 0,
    this.totalAttempts = 0,
    this.correctAnswers = 0,
    this.startedDay = 0,
  });

  final int xp;
  final int completedLessons;
  final int completedExercises;
  final int completedProjects;
  final int currentStreak;
  final int completedChallenges;
  final int completedPredictions;
  final int completedQuizQuestions;
  final int bestStreak;
  final int streakProtections;
  final int learningMinutes;
  final int totalAttempts;
  final int correctAnswers;
  final int startedDay;

  int get level => levelForXp(xp);
  int get currentLevelStart => xpForLevel(level);
  int get nextLevelXp => xpForLevel(level + 1);
  double get levelProgress =>
      (xp - currentLevelStart) / (nextLevelXp - currentLevelStart);
  double get accuracy =>
      totalAttempts == 0 ? 0 : (correctAnswers / totalAttempts).clamp(0, 1);

  static int levelForXp(int xp) {
    var level = 1;
    while (xp >= xpForLevel(level + 1)) {
      level++;
    }
    return level;
  }

  static int xpForLevel(int level) => (level - 1) * level * 50;
}

class ConceptReview {
  const ConceptReview({
    required this.conceptId,
    required this.errorCount,
    required this.successCount,
    required this.nextReviewDay,
  });

  final String conceptId;
  final int errorCount;
  final int successCount;
  final int nextReviewDay;

  double get mastery {
    final total = errorCount + successCount;
    return total == 0 ? 0 : successCount / total;
  }

  bool get isDue {
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day)
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerDay;
    return nextReviewDay <= today;
  }
}

class ActivityProgressState {
  const ActivityProgressState({
    required this.attempts,
    required this.hintsUsed,
    required this.solutionViewed,
  });

  final int attempts;
  final int hintsUsed;
  final bool solutionViewed;

  static const empty = ActivityProgressState(
    attempts: 0,
    hintsUsed: 0,
    solutionViewed: false,
  );
}
