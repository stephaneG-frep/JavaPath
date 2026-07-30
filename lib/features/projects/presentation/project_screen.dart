import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/code_block.dart';
import '../../courses/domain/activity_models.dart';
import '../../progress/data/progress_repository.dart';
import '../data/project_repository.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider(projectId));
    final completedMissions =
        ref
            .watch(completedActivityIdsProvider('project_mission'))
            .valueOrNull ??
        const <String>{};
    final completedProjects =
        ref.watch(completedActivityIdsProvider('project')).valueOrNull ??
        const <String>{};
    if (project == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final completedCount = project.missions
        .where(
          (mission) =>
              completedMissions.contains('${project.id}:${mission.id}'),
        )
        .length;
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: completedCount / project.missions.length,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '$completedCount/${project.missions.length} missions',
                      ),
                      const Spacer(),
                      Text(
                        completedProjects.contains(project.id)
                            ? 'Projet terminé'
                            : '+${project.xpReward} XP à la fin',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Missions',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (var index = 0; index < project.missions.length; index++)
            _MissionCard(
              project: project,
              mission: project.missions[index],
              completedMissionIds: completedMissions,
              isUnlocked:
                  index == 0 ||
                  completedMissions.contains(
                    '${project.id}:${project.missions[index - 1].id}',
                  ),
            ),
        ],
      ),
    );
  }
}

class _MissionCard extends ConsumerWidget {
  const _MissionCard({
    required this.project,
    required this.mission,
    required this.completedMissionIds,
    required this.isUnlocked,
  });

  final LearningProject project;
  final ProjectMission mission;
  final Set<String> completedMissionIds;
  final bool isUnlocked;

  String get _completionId => '${project.id}:${mission.id}';

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mission terminée ?'),
        content: const Text(
          'Confirme seulement après avoir testé ton code et vérifié tous les critères.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Pas encore'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Je confirme'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final repository = ref.read(progressRepositoryProvider);
    final newlyCompleted = await repository.completeActivity(
      activityId: _completionId,
      activityType: 'project_mission',
      xp: 0,
    );
    final currentCompleted = project.missions
        .where(
          (item) => completedMissionIds.contains('${project.id}:${item.id}'),
        )
        .length;
    final completedAfter =
        currentCompleted +
        (newlyCompleted && !completedMissionIds.contains(_completionId)
            ? 1
            : 0);
    final projectFinished = completedAfter == project.missions.length;
    if (projectFinished) {
      final earned = await repository.completeActivity(
        activityId: project.id,
        activityType: 'project',
        xp: project.xpReward,
      );
      if (earned && context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.emoji_events_rounded, size: 52),
            title: const Text('Projet terminé !'),
            content: Text(
              'Bravo, toutes les missions sont validées. '
              '+${project.xpReward} XP',
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Super'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = completedMissionIds.contains(_completionId);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        enabled: isUnlocked,
        leading: CircleAvatar(
          backgroundColor: completed
              ? Colors.green.withValues(alpha: 0.18)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: completed
              ? const Icon(Icons.check_rounded)
              : isUnlocked
              ? Text('${mission.order}')
              : const Icon(Icons.lock_outline_rounded, size: 19),
        ),
        title: Text(
          mission.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          completed
              ? 'Terminée'
              : isUnlocked
              ? 'Appuie pour voir la mission'
              : 'Termine la mission précédente',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mission.instructions),
          const SizedBox(height: 16),
          const Text(
            'Critères de réussite',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          for (final criterion in mission.successCriteria)
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline_rounded, size: 19),
                  const SizedBox(width: 8),
                  Expanded(child: Text(criterion)),
                ],
              ),
            ),
          const SizedBox(height: 18),
          const Text(
            'Code de départ',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          CodeBlock(code: mission.starterCode),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: completed ? null : () => _complete(context, ref),
              icon: Icon(
                completed ? Icons.check_rounded : Icons.task_alt_rounded,
              ),
              label: Text(
                completed ? 'Mission terminée' : 'J’ai terminé cette mission',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
