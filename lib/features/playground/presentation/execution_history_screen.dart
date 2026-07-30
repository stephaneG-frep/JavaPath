import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/playground_repository.dart';
import '../domain/playground_models.dart';

class ExecutionHistoryScreen extends ConsumerWidget {
  const ExecutionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(executionHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Historique')),
      body: AsyncValueView<List<ExecutionHistoryEntry>>(
        value: history,
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('Aucune tentative dans l’historique.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final entry = items[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  onTap: () => context.push('/playground', extra: entry.code),
                  leading: const CircleAvatar(
                    child: Icon(Icons.history_rounded),
                  ),
                  title: Text(
                    entry.code.split('\n').first,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${_formatDate(entry.executedAt)} • '
                    '${_statusLabel(entry.status)}',
                  ),
                  trailing: const Icon(Icons.restore_page_rounded),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(date.day)}/${twoDigits(date.month)} '
        '${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }

  String _statusLabel(String status) {
    return status == JavaExecutionStatus.unavailable.name
        ? 'Mode démonstration'
        : status;
  }
}
