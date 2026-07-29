import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../progress/data/progress_repository.dart';
import '../../progress/domain/progress_models.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(conceptReviewsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('À réviser')),
      body: reviews.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (items) => _ReviewContent(items: items),
      ),
    );
  }
}

class _ReviewContent extends StatelessWidget {
  const _ReviewContent({required this.items});

  final List<ConceptReview> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Aucune faiblesse détectée pour le moment.\n'
            'Fais quelques quiz ou exercices pour obtenir des recommandations.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final due = items.where((item) => item.isDue).toList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              '${due.length} notion(s) à revoir aujourd’hui. '
              'Une réussite espacera progressivement la prochaine révision.',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final item in items)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.conceptId,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Chip(
                        label: Text(
                          item.isDue ? 'À revoir' : 'Planifiée',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: item.mastery),
                  const SizedBox(height: 6),
                  Text(
                    'Maîtrise estimée : '
                    '${(item.mastery * 100).round()} % • '
                    '${item.errorCount} erreur(s)',
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonal(
                      onPressed: () => context.push('/quiz'),
                      child: const Text('Réviser maintenant'),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
