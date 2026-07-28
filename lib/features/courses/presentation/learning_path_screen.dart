import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/course_repository.dart';
import '../domain/learning_models.dart';
import '../../progress/data/progress_repository.dart';

class LearningPathScreen extends ConsumerWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(learningPathProvider);
    final xp = ref.watch(userProgressProvider).valueOrNull?.xp ?? 0;
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
        data: (value) => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: value.modules.length,
          itemBuilder: (context, index) {
            final module = value.modules[index];
            return _ModuleCard(module: module);
          },
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.module});
  final LearningModule module;

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
                      Text('NIVEAU ${module.level}',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(module.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800)),
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
              ),
            const Divider(height: 28),
            Row(
              children: [
                const Icon(Icons.rocket_launch_rounded, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text('Projet : ${module.projectTitle}')),
                const Icon(Icons.lock_outline_rounded),
              ],
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
  });
  final Lesson lesson;
  final int position;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => context.push('/lesson/${lesson.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text('$position'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lesson.title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text('${lesson.estimatedMinutes} min • +${lesson.xpReward} XP'),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
