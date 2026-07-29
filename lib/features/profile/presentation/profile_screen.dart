import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/app_preferences.dart';
import '../../progress/data/progress_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
          Text(
            'Java Rookie',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
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
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('Objectif'),
                  subtitle: Text(settings.learningGoal ?? 'Non défini'),
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
                  Text('Apparence',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
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
        ],
      ),
    );
  }
}
