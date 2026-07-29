import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/services/streak_calculator.dart';

void main() {
  test('une activité le lendemain prolonge la série', () {
    final result = StreakCalculator.calculate(
      lastActivityDay: 100,
      today: 101,
      current: 4,
      best: 6,
      protections: 1,
    );

    expect(result.current, 5);
    expect(result.best, 6);
    expect(result.protections, 1);
  });

  test('une journée manquée utilise la protection', () {
    final result = StreakCalculator.calculate(
      lastActivityDay: 100,
      today: 102,
      current: 6,
      best: 6,
      protections: 1,
    );

    expect(result.current, 7);
    expect(result.best, 7);
    expect(result.protections, 0);
  });

  test('une longue absence redémarre doucement à un', () {
    final result = StreakCalculator.calculate(
      lastActivityDay: 100,
      today: 105,
      current: 8,
      best: 8,
      protections: 1,
    );

    expect(result.current, 1);
    expect(result.best, 8);
  });
}
