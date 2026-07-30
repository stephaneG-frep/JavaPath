import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/code_block.dart';
import '../data/course_repository.dart';
import '../domain/learning_models.dart';
import '../../progress/data/progress_repository.dart';

class LessonScreen extends ConsumerWidget {
  const LessonScreen({required this.lessonId, super.key});
  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson = ref.watch(lessonProvider(lessonId));
    if (lesson == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final isCompleted =
        ref
            .watch(completedLessonIdsProvider)
            .valueOrNull
            ?.contains(lesson.id) ??
        false;
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: _LessonContent(lesson: lesson),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: isCompleted
              ? null
              : () async {
                  final earned = await ref
                      .read(progressRepositoryProvider)
                      .completeLesson(
                        lesson.id,
                        lesson.xpReward,
                        lesson.estimatedMinutes,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          earned
                              ? 'Leçon terminée : +${lesson.xpReward} XP'
                              : 'Cette leçon était déjà terminée.',
                        ),
                      ),
                    );
                  }
                },
          icon: Icon(
            isCompleted
                ? Icons.check_circle_rounded
                : Icons.check_circle_outline_rounded,
          ),
          label: Text(isCompleted ? 'Leçon terminée' : 'Terminer la leçon'),
        ),
      ),
    );
  }
}

class _LessonContent extends StatelessWidget {
  const _LessonContent({required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Wrap(
          spacing: 8,
          children: [
            Chip(
              avatar: const Icon(Icons.schedule_rounded, size: 18),
              label: Text('${lesson.estimatedMinutes} min'),
            ),
            Chip(
              avatar: const Icon(Icons.bolt_rounded, size: 18),
              label: Text('+${lesson.xpReward} XP'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          lesson.description,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        for (final section in lesson.sections) ...[
          Text(
            section.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            section.content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
        ],
        for (final example in lesson.codeExamples) ...[
          Text(
            example.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          CodeBlock(code: example.code),
          const SizedBox(height: 10),
          Text(
            example.explanation,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}
