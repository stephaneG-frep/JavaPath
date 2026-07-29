abstract final class ReviewPolicy {
  static int intervalDays(int successfulReviews) {
    return switch (successfulReviews) {
      <= 0 => 0,
      1 => 1,
      2 => 3,
      3 => 7,
      4 => 14,
      _ => 30,
    };
  }

  static double mastery({
    required int errors,
    required int successes,
  }) {
    final total = errors + successes;
    if (total == 0) return 0;
    return successes / total;
  }
}
