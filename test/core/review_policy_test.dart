import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/services/review_policy.dart';

void main() {
  test('les intervalles augmentent avec les réussites', () {
    expect(ReviewPolicy.intervalDays(1), 1);
    expect(ReviewPolicy.intervalDays(2), 3);
    expect(ReviewPolicy.intervalDays(3), 7);
    expect(ReviewPolicy.intervalDays(4), 14);
    expect(ReviewPolicy.intervalDays(5), 30);
  });

  test('calcule la maîtrise à partir des erreurs et réussites', () {
    expect(ReviewPolicy.mastery(errors: 1, successes: 3), 0.75);
    expect(ReviewPolicy.mastery(errors: 0, successes: 0), 0);
  });
}
