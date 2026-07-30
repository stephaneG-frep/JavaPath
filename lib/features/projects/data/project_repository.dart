import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../courses/domain/activity_models.dart';

abstract interface class ProjectRepository {
  Future<List<LearningProject>> loadProjects();
}

class AssetProjectRepository implements ProjectRepository {
  const AssetProjectRepository();

  @override
  Future<List<LearningProject>> loadProjects() async {
    final sources = await Future.wait([
      rootBundle.loadString('assets/content/projects_fr.json'),
      rootBundle.loadString('assets/content/projects_modern_fr.json'),
    ]);
    final projects = <LearningProject>[];
    for (final source in sources) {
      final json = jsonDecode(source) as Map<String, dynamic>;
      projects.addAll(
        (json['projects'] as List<dynamic>).map(
          (item) => LearningProject.fromJson(item as Map<String, dynamic>),
        ),
      );
    }
    return projects;
  }
}

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => const AssetProjectRepository(),
);

final projectsProvider = FutureProvider<List<LearningProject>>(
  (ref) => ref.watch(projectRepositoryProvider).loadProjects(),
);

final projectProvider = Provider.family<LearningProject?, String>((
  ref,
  projectId,
) {
  final projects = ref.watch(projectsProvider).valueOrNull;
  for (final project in projects ?? const <LearningProject>[]) {
    if (project.id == projectId) return project;
  }
  return null;
});
