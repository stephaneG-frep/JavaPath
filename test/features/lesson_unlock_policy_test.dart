import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';
import 'package:java_path/features/courses/domain/lesson_unlock_policy.dart';

Lesson _lesson(String id) => Lesson(
      id: id,
      moduleId: 'module',
      title: id,
      description: '',
      difficulty: LessonDifficulty.debutant,
      estimatedMinutes: 5,
      xpReward: 10,
      sections: const [],
      codeExamples: const [],
    );

void main() {
  test('seule la première leçon est ouverte au départ', () {
    final unlocked = LessonUnlockPolicy.unlockedIds(
      lessons: [_lesson('a'), _lesson('b'), _lesson('c')],
      completedIds: const {},
    );

    expect(unlocked, {'a'});
  });

  test('terminer une leçon ouvre immédiatement la suivante', () {
    final unlocked = LessonUnlockPolicy.unlockedIds(
      lessons: [_lesson('a'), _lesson('b'), _lesson('c')],
      completedIds: const {'a', 'b'},
    );

    expect(unlocked, {'a', 'b', 'c'});
  });
}
