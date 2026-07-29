abstract final class HintPolicy {
  static int reward({
    required int baseXp,
    required int hintsUsed,
    required bool solutionViewed,
  }) {
    if (solutionViewed) return 0;
    final reduced = baseXp - (hintsUsed * 5);
    return reduced.clamp(0, baseXp);
  }
}
