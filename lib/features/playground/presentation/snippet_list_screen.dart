import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/playground_repository.dart';
import '../domain/playground_models.dart';

class SnippetListScreen extends ConsumerWidget {
  const SnippetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snippets = ref.watch(savedSnippetsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mes snippets')),
      body: AsyncValueView<List<SavedCodeSnippet>>(
        value: snippets,
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Aucun snippet sauvegardé.\n'
                  'Utilise le bouton Sauvegarder dans le playground.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final snippet = items[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  onTap: () => context.push('/playground', extra: snippet.code),
                  leading: const CircleAvatar(child: Icon(Icons.code_rounded)),
                  title: Text(
                    snippet.title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    snippet.code.split('\n').first,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    tooltip: snippet.isFavorite
                        ? 'Retirer des favoris'
                        : 'Ajouter aux favoris',
                    onPressed: () => ref
                        .read(playgroundRepositoryProvider)
                        .toggleFavorite(snippet.id, !snippet.isFavorite),
                    icon: Icon(
                      snippet.isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
