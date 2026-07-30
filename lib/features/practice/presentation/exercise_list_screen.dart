import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/practice_repository.dart';

class ExerciseListScreen extends ConsumerWidget {
  const ExerciseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(practiceCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Exercices')),
      body: AsyncValueView(
        value: catalog,
        data: (value) => ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: value.exercises.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final exercise = value.exercises[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                onTap: () => context.push('/exercise/${exercise.id}'),
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(
                  exercise.prompt.split('\n').first,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  '${exercise.difficulty} • +${exercise.xpReward} XP',
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            );
          },
        ),
      ),
    );
  }
}
