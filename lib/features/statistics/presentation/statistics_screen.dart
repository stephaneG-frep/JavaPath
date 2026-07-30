import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../courses/data/course_repository.dart';
import '../../practice/data/challenge_repository.dart';
import '../../practice/data/practice_repository.dart';
import '../../projects/data/project_repository.dart';
import '../../progress/data/progress_repository.dart';
import '../../progress/domain/progress_models.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    final path = ref.watch(learningPathProvider).valueOrNull;
    final practice = ref.watch(practiceCatalogProvider).valueOrNull;
    final challenges = ref.watch(challengeCatalogProvider).valueOrNull;
    final projects = ref.watch(projectsProvider).valueOrNull;
    final targets = _ActivityTargets(
      lessons: path?.modules.expand((module) => module.lessons).length ?? 52,
      quizQuestions: practice?.quizQuestions.length ?? 50,
      exercises: practice?.exercises.length ?? 34,
      debugChallenges: challenges?.debugChallenges.length ?? 5,
      predictions: challenges?.predictions.length ?? 5,
      projects: projects?.length ?? 4,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (value) => _StatisticsContent(progress: value, targets: targets),
      ),
    );
  }
}

class _StatisticsContent extends StatelessWidget {
  const _StatisticsContent({required this.progress, required this.targets});

  final UserProgress progress;
  final _ActivityTargets targets;

  @override
  Widget build(BuildContext context) {
    final hours = progress.learningMinutes ~/ 60;
    final minutes = progress.learningMinutes % 60;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.45,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _StatCard(
              icon: Icons.schedule_rounded,
              value: '${hours}h ${minutes}min',
              label: 'Temps estimé',
            ),
            _StatCard(
              icon: Icons.bolt_rounded,
              value: '${progress.xp}',
              label: 'XP',
            ),
            _StatCard(
              icon: Icons.local_fire_department_rounded,
              value: '${progress.currentStreak} jours',
              label: 'Série actuelle',
            ),
            _StatCard(
              icon: Icons.emoji_events_outlined,
              value: '${progress.bestStreak} jours',
              label: 'Meilleure série',
            ),
          ],
        ),
        const SizedBox(height: 22),
        Text(
          'Précision globale',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${(progress.accuracy * 100).round()} %',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Text(
                      '${progress.correctAnswers}/'
                      '${progress.totalAttempts} réussites',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: progress.accuracy),
                const SizedBox(height: 8),
                const Text(
                  'La précision utilise les tentatives enregistrées depuis '
                  'cette version de JavaPath.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Activités terminées',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _ActivityProgress(
          label: 'Leçons',
          value: progress.completedLessons,
          target: targets.lessons,
          icon: Icons.menu_book_rounded,
        ),
        _ActivityProgress(
          label: 'Questions de quiz',
          value: progress.completedQuizQuestions,
          target: targets.quizQuestions,
          icon: Icons.quiz_rounded,
        ),
        _ActivityProgress(
          label: 'Exercices',
          value: progress.completedExercises,
          target: targets.exercises,
          icon: Icons.edit_note_rounded,
        ),
        _ActivityProgress(
          label: 'Debug Challenges',
          value: progress.completedChallenges,
          target: targets.debugChallenges,
          icon: Icons.bug_report_rounded,
        ),
        _ActivityProgress(
          label: 'Prédictions',
          value: progress.completedPredictions,
          target: targets.predictions,
          icon: Icons.visibility_rounded,
        ),
        _ActivityProgress(
          label: 'Projets',
          value: progress.completedProjects,
          target: targets.projects,
          icon: Icons.rocket_launch_rounded,
        ),
      ],
    );
  }
}

class _ActivityTargets {
  const _ActivityTargets({
    required this.lessons,
    required this.quizQuestions,
    required this.exercises,
    required this.debugChallenges,
    required this.predictions,
    required this.projects,
  });

  final int lessons;
  final int quizQuestions;
  final int exercises;
  final int debugChallenges;
  final int predictions;
  final int projects;
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const Spacer(),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _ActivityProgress extends StatelessWidget {
  const _ActivityProgress({
    required this.label,
    required this.value,
    required this.target,
    required this.icon,
  });

  final String label;
  final int value;
  final int target;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Text('$value/$target'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: (value / target).clamp(0, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
