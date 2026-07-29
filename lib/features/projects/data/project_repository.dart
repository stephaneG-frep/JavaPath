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
    final source =
        await rootBundle.loadString('assets/content/projects_fr.json');
    final json = jsonDecode(source) as Map<String, dynamic>;
    return (json['projects'] as List<dynamic>)
        .map((item) => LearningProject.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => const AssetProjectRepository(),
);

final projectsProvider = FutureProvider<List<LearningProject>>(
  (ref) => ref.watch(projectRepositoryProvider).loadProjects(),
);

final projectProvider =
    Provider.family<LearningProject?, String>((ref, projectId) {
  final projects = ref.watch(projectsProvider).valueOrNull;
  for (final project in projects ?? const <LearningProject>[]) {
    if (project.id == projectId) return project;
  }
  return null;
});
