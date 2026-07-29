import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../courses/domain/activity_models.dart';
import '../../progress/data/progress_repository.dart';
import '../data/project_repository.dart';

class ProjectListScreen extends ConsumerWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final completedMissions =
        ref.watch(completedActivityIdsProvider('project_mission')).valueOrNull ??
            const <String>{};
    final completedProjects =
        ref.watch(completedActivityIdsProvider('project')).valueOrNull ??
            const <String>{};
    return Scaffold(
      appBar: AppBar(title: const Text('Projets Java')),
      body: AsyncValueView<List<LearningProject>>(
        value: projects,
        data: (items) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.rocket_launch_rounded, size: 42),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Construis quelque chose de concret',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Chaque projet est découpé en petites missions. '
                            'Suis-les dans l’ordre et vérifie chaque critère.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            for (final project in items)
              _ProjectCard(
                project: project,
                completedMissionIds: completedMissions,
                isCompleted: completedProjects.contains(project.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.completedMissionIds,
    required this.isCompleted,
  });

  final LearningProject project;
  final Set<String> completedMissionIds;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final completed = project.missions
        .where(
          (mission) =>
              completedMissionIds.contains('${project.id}:${mission.id}'),
        )
        .length;
    final progress = completed / project.missions.length;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/project/${project.id}'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(
                      isCompleted
                          ? Icons.check_rounded
                          : Icons.terminal_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '${project.difficulty} • environ '
                          '${project.estimatedHours} h',
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
              const SizedBox(height: 14),
              Text(project.description),
              const SizedBox(height: 14),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final concept in project.concepts)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(concept),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 7),
              Row(
                children: [
                  Text('$completed/${project.missions.length} missions'),
                  const Spacer(),
                  Text(
                    isCompleted ? 'Terminé' : '+${project.xpReward} XP',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
