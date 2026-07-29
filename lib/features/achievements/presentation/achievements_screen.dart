import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../progress/data/progress_repository.dart';
import '../../progress/domain/achievement_service.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Badges')),
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (value) {
          final badges = AchievementService.evaluate(value);
          final unlocked = badges.where((badge) => badge.isUnlocked).length;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_rounded, size: 44),
                      const SizedBox(width: 14),
                      Text(
                        '$unlocked/${badges.length} badges débloqués',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final badge in badges) _BadgeCard(status: badge),
            ],
          );
        },
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.status});

  final AchievementStatus status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: status.isUnlocked
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(
                _icon(status.iconKey),
                color: status.isUnlocked ? null : Colors.grey,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(status.description),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: status.progress),
                  const SizedBox(height: 4),
                  Text(
                    status.isUnlocked
                        ? 'Débloqué'
                        : '${status.current}/${status.target}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(String key) {
    return switch (key) {
      'code' => Icons.code_rounded,
      'quiz' => Icons.quiz_rounded,
      'exercise' => Icons.edit_note_rounded,
      'bug' => Icons.bug_report_rounded,
      'project' => Icons.rocket_launch_rounded,
      'streak' => Icons.local_fire_department_rounded,
      'xp' => Icons.bolt_rounded,
      'object' => Icons.account_tree_rounded,
      _ => Icons.school_rounded,
    };
  }
}
