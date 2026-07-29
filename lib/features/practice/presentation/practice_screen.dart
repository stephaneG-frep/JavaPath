import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/practice_repository.dart';

class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(practiceCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Pratiquer')),
      body: AsyncValueView(
        value: catalog,
        data: (value) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Transforme la théorie en réflexes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Teste ta compréhension, puis lis pourquoi une réponse est juste.',
            ),
            const SizedBox(height: 24),
            _PracticeCard(
              icon: Icons.quiz_rounded,
              title: 'Quiz Java',
              description:
                  '${value.quizQuestions.length} questions sur les fondamentaux',
              badge: '+5 XP par réponse',
              color: Theme.of(context).colorScheme.primaryContainer,
              onTap: () => context.push('/quiz'),
            ),
            const SizedBox(height: 14),
            _PracticeCard(
              icon: Icons.edit_note_rounded,
              title: 'Exercices',
              description:
                  '${value.exercises.length} exercices avec validation',
              badge: '+30 XP par exercice',
              color: Theme.of(context).colorScheme.secondaryContainer,
              onTap: () => context.push('/exercises'),
            ),
            const SizedBox(height: 14),
            _PracticeCard(
              icon: Icons.bug_report_rounded,
              title: 'Debug Challenge',
              description: '5 programmes à diagnostiquer et corriger',
              badge: 'Jusqu’à +50 XP',
              color: Theme.of(context).colorScheme.tertiaryContainer,
              onTap: () => context.push('/challenges'),
            ),
            const SizedBox(height: 14),
            _PracticeCard(
              icon: Icons.visibility_rounded,
              title: 'Prédire le résultat',
              description: '5 programmes à exécuter dans ta tête',
              badge: 'Jusqu’à +30 XP',
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              onTap: () => context.push('/challenges'),
            ),
            const SizedBox(height: 14),
            const _LockedPracticeCard(
              icon: Icons.terminal_rounded,
              title: 'Playground Java',
              phase: 'Phase 6',
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.badge,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final String badge;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 46),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(description),
                    const SizedBox(height: 10),
                    Text(badge,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _LockedPracticeCard extends StatelessWidget {
  const _LockedPracticeCard({
    required this.icon,
    required this.title,
    required this.phase,
  });
  final IconData icon;
  final String title;
  final String phase;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('Prévu pour la $phase'),
        trailing: const Icon(Icons.lock_outline_rounded),
      ),
    );
  }
}
