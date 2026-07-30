import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/course_repository.dart';
import '../domain/learning_models.dart';
import '../domain/lesson_unlock_policy.dart';
import '../../progress/data/progress_repository.dart';

final _selectedLearningLevelProvider = StateProvider<int?>((ref) => null);

class LearningPathScreen extends ConsumerWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(learningPathProvider);
    final xp = ref.watch(userProgressProvider).valueOrNull?.xp ?? 0;
    final completed =
        ref.watch(completedLessonIdsProvider).valueOrNull ?? const <String>{};
    final selectedLevel = ref.watch(_selectedLearningLevelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parcours Java'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              avatar: const Icon(Icons.bolt_rounded, size: 18),
              label: Text('$xp XP'),
            ),
          ),
        ],
      ),
      body: AsyncValueView<LearningPath>(
        value: path,
        data: (value) {
          final lessons = value.modules
              .expand((module) => module.lessons)
              .toList();
          final unlocked = LessonUnlockPolicy.unlockedIds(
            lessons: lessons,
            completedIds: completed,
          );
          final levels =
              value.modules.map((module) => module.level).toSet().toList()
                ..sort();
          final incompleteLessons = lessons
              .where((lesson) => !completed.contains(lesson.id))
              .toList();
          final nextLessonId = incompleteLessons.isEmpty
              ? null
              : incompleteLessons.first.id;
          final activeLevel = value.modules
              .firstWhere(
                (module) =>
                    module.lessons.any((lesson) => lesson.id == nextLessonId),
                orElse: () => value.modules.last,
              )
              .level;
          final visibleLevel = selectedLevel ?? activeLevel;
          final visibleModules = value.modules
              .where((module) => module.level == visibleLevel)
              .toList();

          return Column(
            children: [
              SizedBox(
                height: 58,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 6),
                  scrollDirection: Axis.horizontal,
                  itemCount: levels.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final level = levels.elementAt(index);
                    return FilterChip(
                      selected: visibleLevel == level,
                      avatar: level == activeLevel
                          ? const Icon(Icons.play_arrow_rounded, size: 18)
                          : null,
                      label: Text('Niveau $level'),
                      onSelected: (_) =>
                          ref
                                  .read(_selectedLearningLevelProvider.notifier)
                                  .state =
                              level,
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  itemCount: visibleModules.length,
                  itemBuilder: (context, index) {
                    final module = visibleModules[index];
                    return _ModuleCard(
                      key: ValueKey(module.id),
                      module: module,
                      completed: completed,
                      unlocked: unlocked,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    super.key,
    required this.module,
    required this.completed,
    required this.unlocked,
  });
  final LearningModule module;
  final Set<String> completed;
  final Set<String> unlocked;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text('${module.level}')),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIVEAU ${module.level}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        module.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(module.description),
            const SizedBox(height: 18),
            for (var index = 0; index < module.lessons.length; index++)
              _LessonTile(
                lesson: module.lessons[index],
                position: index + 1,
                isLast: index == module.lessons.length - 1,
                isCompleted: completed.contains(module.lessons[index].id),
                isUnlocked:
                    unlocked.contains(module.lessons[index].id) ||
                    completed.contains(module.lessons[index].id),
              ),
            const Divider(height: 28),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: module.projectId == null
                  ? null
                  : () => context.push('/project/${module.projectId}'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.rocket_launch_rounded, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Projet : ${module.projectTitle}')),
                    Icon(
                      module.projectId == null
                          ? Icons.lock_outline_rounded
                          : Icons.chevron_right_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({
    required this.lesson,
    required this.position,
    required this.isLast,
    required this.isCompleted,
    required this.isUnlocked,
  });
  final Lesson lesson;
  final int position;
  final bool isLast;
  final bool isCompleted;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: isUnlocked ? () => context.push('/lesson/${lesson.id}') : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: isCompleted
                  ? Colors.green.withValues(alpha: 0.18)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              child: isCompleted
                  ? const Icon(Icons.check_rounded, size: 18)
                  : isUnlocked
                  ? Text('$position')
                  : const Icon(Icons.lock_outline_rounded, size: 17),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${lesson.estimatedMinutes} min • +${lesson.xpReward} XP',
                  ),
                ],
              ),
            ),
            Icon(
              isUnlocked
                  ? Icons.chevron_right_rounded
                  : Icons.lock_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
