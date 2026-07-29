import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:highlight/languages/java.dart';

import '../data/playground_repository.dart';
import '../domain/playground_models.dart';

class PlaygroundScreen extends ConsumerStatefulWidget {
  const PlaygroundScreen({this.initialCode, super.key});

  final String? initialCode;

  @override
  ConsumerState<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends ConsumerState<PlaygroundScreen> {
  static const _example = 'public class Main {\n'
      '  public static void main(String[] args) {\n'
      '    System.out.println("Bonjour JavaPath !");\n'
      '  }\n'
      '}';

  late final CodeController _controller;
  JavaExecutionResult? _result;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: widget.initialCode ?? _example,
      language: java,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    FocusScope.of(context).unfocus();
    setState(() => _running = true);
    final result =
        await ref.read(javaExecutionServiceProvider).execute(_controller.fullText);
    await ref
        .read(playgroundRepositoryProvider)
        .recordExecution(result, _controller.fullText);
    if (!mounted) return;
    setState(() {
      _result = result;
      _running = false;
    });
  }

  Future<void> _save() async {
    if (_controller.fullText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le code est vide.')),
      );
      return;
    }
    final titleController = TextEditingController(text: 'Mon programme Java');
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sauvegarder le snippet'),
        content: TextField(
          controller: titleController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Titre'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              titleController.text.trim(),
            ),
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
    titleController.dispose();
    if (title == null || title.isEmpty) return;
    await ref
        .read(playgroundRepositoryProvider)
        .saveSnippet(title, _controller.fullText);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Snippet sauvegardé hors ligne.')),
      );
    }
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _controller.fullText));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code copié.')),
      );
    }
  }

  void _replaceCode(String code) {
    _controller.fullText = code;
    setState(() => _result = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playground Java'),
        actions: [
          IconButton(
            tooltip: 'Snippets sauvegardés',
            onPressed: () => context.push('/playground/snippets'),
            icon: const Icon(Icons.bookmarks_outlined),
          ),
          IconButton(
            tooltip: 'Historique',
            onPressed: () => context.push('/playground/history'),
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: const ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text(
                'Mode démonstration local',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                'L’éditeur fonctionne hors ligne, mais aucune JVM ne compile '
                'ou n’exécute encore ce code sur le téléphone.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              IconButton.filledTonal(
                tooltip: 'Copier',
                onPressed: _copy,
                icon: const Icon(Icons.copy_rounded),
              ),
              IconButton.filledTonal(
                tooltip: 'Effacer',
                onPressed: () => _replaceCode(''),
                icon: const Icon(Icons.delete_sweep_outlined),
              ),
              IconButton.filledTonal(
                tooltip: 'Réinitialiser',
                onPressed: () => _replaceCode(_example),
                icon: const Icon(Icons.restart_alt_rounded),
              ),
              FilledButton.tonalIcon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Sauvegarder'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _replaceCode(_example),
                icon: const Icon(Icons.data_object_rounded),
                label: const Text('Exemple'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ColoredBox(
              color: const Color(0xFF23241F),
              child: CodeTheme(
                data: CodeThemeData(styles: monokaiSublimeTheme),
                child: CodeField(
                  controller: _controller,
                  minLines: 14,
                  wrap: false,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: _running ? null : _run,
              icon: _running
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow_rounded),
              label: Text(_running ? 'Préparation…' : 'Exécuter'),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Console',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(minHeight: 130),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SelectableText(
              _result?.output ??
                  'La console affichera ici le statut du service d’exécution.',
              style: TextStyle(
                color: _result?.status == JavaExecutionStatus.unavailable
                    ? const Color(0xFFFBBF24)
                    : const Color(0xFFF9FAFB),
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
