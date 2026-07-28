import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../courses/data/course_repository.dart';
import '../../progress/data/progress_repository.dart';
import '../../progress/domain/progress_models.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    final path = ref.watch(learningPathProvider);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(learningPathProvider);
            await ref.read(learningPathProvider.future);
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bonjour 👋',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w800)),
                        const Text('Prêt à faire un pas de plus en Java ?'),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.code_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AsyncValueView<UserProgress>(
                value: progress,
                data: (value) => _ProgressCard(progress: value),
              ),
              const SizedBox(height: 24),
              Text('Continuer mon apprentissage',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              AsyncValueView(
                value: path,
                data: (learningPath) {
                  final lesson = learningPath.modules.first.lessons.first;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('PROCHAINE ÉTAPE'),
                          const SizedBox(height: 8),
                          Text(lesson.title,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text(lesson.description),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.schedule_rounded,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 6),
                              Text('${lesson.estimatedMinutes} min'),
                              const Spacer(),
                              FilledButton.icon(
                                onPressed: () =>
                                    context.push('/lesson/${lesson.id}'),
                                icon: const Icon(Icons.play_arrow_rounded),
                                label: const Text('Commencer'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text('Raccourcis',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 4 : 2,
                childAspectRatio: 1.55,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _Shortcut(
                    label: 'Cours',
                    icon: Icons.menu_book_rounded,
                    onTap: () => context.go('/learn'),
                  ),
                  _Shortcut(
                    label: 'Playground',
                    icon: Icons.terminal_rounded,
                    onTap: () => context.go('/practice'),
                  ),
                  _Shortcut(
                    label: 'Exercices',
                    icon: Icons.edit_note_rounded,
                    onTap: () => context.go('/practice'),
                  ),
                  _Shortcut(
                    label: 'Projets',
                    icon: Icons.rocket_launch_rounded,
                    onTap: () => context.go('/projects'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Défi du jour',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: const ListTile(
                  contentPadding: EdgeInsets.all(18),
                  leading: Icon(Icons.bug_report_rounded, size: 36),
                  title: Text('Trouve le bug'),
                  subtitle: Text(
                    'int age = "25";\nPourquoi Java refuse-t-il cette ligne ?',
                  ),
                  trailing: Icon(Icons.lock_clock_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.progress});
  final UserProgress progress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department_rounded),
                Text(' ${progress.currentStreak} jour',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('Niveau ${progress.level}',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 14),
            LinearProgressIndicator(value: progress.levelProgress),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${progress.xp} XP'),
                const Spacer(),
                Text('${progress.nextLevelXp} XP'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  const _Shortcut({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
