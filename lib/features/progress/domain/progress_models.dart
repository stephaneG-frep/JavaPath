class UserProgress {
  const UserProgress({
    required this.xp,
    required this.completedLessons,
    required this.completedExercises,
    required this.completedProjects,
    required this.currentStreak,
  });

  final int xp;
  final int completedLessons;
  final int completedExercises;
  final int completedProjects;
  final int currentStreak;

  int get level => levelForXp(xp);
  int get currentLevelStart => xpForLevel(level);
  int get nextLevelXp => xpForLevel(level + 1);
  double get levelProgress =>
      (xp - currentLevelStart) / (nextLevelXp - currentLevelStart);

  static int levelForXp(int xp) {
    var level = 1;
    while (xp >= xpForLevel(level + 1)) {
      level++;
    }
    return level;
  }

  static int xpForLevel(int level) => (level - 1) * level * 50;
}
