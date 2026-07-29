import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/practice/domain/hint_policy.dart';

void main() {
  test('chaque indice réduit la récompense de 5 XP', () {
    expect(
      HintPolicy.reward(baseXp: 50, hintsUsed: 0, solutionViewed: false),
      50,
    );
    expect(
      HintPolicy.reward(baseXp: 50, hintsUsed: 2, solutionViewed: false),
      40,
    );
  });

  test('la solution complète annule la récompense', () {
    expect(
      HintPolicy.reward(baseXp: 50, hintsUsed: 1, solutionViewed: true),
      0,
    );
  });
}
