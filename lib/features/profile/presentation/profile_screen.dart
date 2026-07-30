import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/app_preferences.dart';
import '../../progress/data/progress_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _goals = [
    'Découvrir la programmation',
    'Apprendre Java',
    'Préparer une formation',
    'Trouver un emploi',
    'Développer des applications',
    'Créer des backends/API',
    'Me perfectionner',
  ];

  Future<void> _editDisplayName(
    BuildContext context,
    WidgetRef ref,
    String currentValue,
  ) async {
    final controller = TextEditingController(text: currentValue);
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le pseudo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 30,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Pseudo',
            hintText: 'Exemple : JavaLearner',
          ),
          onSubmitted: (value) => Navigator.pop(context, value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null && value.trim().isNotEmpty) {
      await ref.read(appSettingsProvider.notifier).setDisplayName(value);
    }
  }

  Future<void> _editGoal(BuildContext context, WidgetRef ref) async {
    final goal = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choisir mon objectif'),
        children: [
          for (final goal in _goals)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, goal),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(goal),
              ),
            ),
        ],
      ),
    );
    if (goal != null) {
      await ref.read(appSettingsProvider.notifier).setLearningGoal(goal);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final progress = ref.watch(userProgressProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 46,
              child: Icon(Icons.code_rounded, size: 46),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  settings.displayName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Modifier le pseudo',
                onPressed: () =>
                    _editDisplayName(context, ref, settings.displayName),
                icon: const Icon(Icons.edit_rounded),
              ),
            ],
          ),
          Text(
            progress?.rankTitle ?? 'Java Rookie',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Niveau ${progress?.level ?? 1} • ${progress?.xp ?? 0} XP',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  onTap: () => _editGoal(context, ref),
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('Objectif'),
                  subtitle: Text(settings.learningGoal ?? 'Non défini'),
                  trailing: const Icon(Icons.edit_rounded),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school_outlined),
                  title: const Text('Niveau de départ'),
                  subtitle: Text(settings.learningLevel ?? 'Non défini'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apparence',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_outlined),
                        label: Text('Clair'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.settings_suggest_outlined),
                        label: Text('Auto'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_outlined),
                        label: Text('Sombre'),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (selection) => ref
                        .read(appSettingsProvider.notifier)
                        .setThemeMode(selection.first),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Taille du texte',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<double>(
                    segments: const [
                      ButtonSegment(
                        value: 0.9,
                        label: Text('A'),
                        tooltip: 'Texte compact',
                      ),
                      ButtonSegment(
                        value: 1,
                        label: Text('A+'),
                        tooltip: 'Texte normal',
                      ),
                      ButtonSegment(
                        value: 1.3,
                        label: Text('A++'),
                        tooltip: 'Texte très grand',
                      ),
                    ],
                    selected: {settings.textScale},
                    onSelectionChanged: (selection) => ref
                        .read(appSettingsProvider.notifier)
                        .setTextScale(selection.first),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () => context.push('/help'),
              leading: const Icon(Icons.help_outline_rounded),
              title: const Text(
                'Mode d’emploi & aide',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                'Comprendre le parcours, l’XP, les indices et le mode hors ligne',
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  onTap: () => context.push('/achievements'),
                  leading: const Icon(Icons.emoji_events_outlined),
                  title: const Text('Badges'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () => context.push('/statistics'),
                  leading: const Icon(Icons.bar_chart_rounded),
                  title: const Text('Statistiques'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () => context.push('/reviews'),
                  leading: const Icon(Icons.refresh_rounded),
                  title: const Text('Révisions intelligentes'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () => context.push('/mentor'),
                  leading: const Icon(Icons.psychology_alt_rounded),
                  title: const Text('Java Mentor'),
                  subtitle: const Text('Guide local — IA non connectée'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'JavaPath',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.code_rounded, size: 42),
                children: const [
                  Text(
                    'Application éducative hors ligne pour apprendre Java. '
                    'La progression reste enregistrée sur cet appareil.',
                  ),
                ],
              ),
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('À propos de JavaPath'),
              subtitle: const Text('Version 1.0.0 • Fonctionnement hors ligne'),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
