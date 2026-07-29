class StreakUpdate {
  const StreakUpdate({
    required this.current,
    required this.best,
    required this.protections,
  });

  final int current;
  final int best;
  final int protections;
}

abstract final class StreakCalculator {
  static StreakUpdate calculate({
    required int? lastActivityDay,
    required int today,
    required int current,
    required int best,
    required int protections,
  }) {
    if (lastActivityDay == null) {
      return StreakUpdate(
        current: 1,
        best: best < 1 ? 1 : best,
        protections: protections,
      );
    }
    final difference = today - lastActivityDay;
    if (difference <= 0) {
      return StreakUpdate(
        current: current,
        best: best,
        protections: protections,
      );
    }
    final protected = difference == 2 && protections > 0;
    final nextCurrent = difference == 1 || protected ? current + 1 : 1;
    return StreakUpdate(
      current: nextCurrent,
      best: nextCurrent > best ? nextCurrent : best,
      protections: protected ? protections - 1 : protections,
    );
  }
}
