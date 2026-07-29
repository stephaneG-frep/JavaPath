import 'learning_models.dart';

abstract final class LessonUnlockPolicy {
  static Set<String> unlockedIds({
    required List<Lesson> lessons,
    required Set<String> completedIds,
  }) {
    final unlocked = <String>{if (lessons.isNotEmpty) lessons.first.id};
    for (var index = 1; index < lessons.length; index++) {
      if (completedIds.contains(lessons[index - 1].id)) {
        unlocked.add(lessons[index].id);
      }
    }
    return unlocked;
  }
}
