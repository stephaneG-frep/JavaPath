import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/learning_models.dart';

abstract interface class CourseRepository {
  Future<LearningPath> loadPath();
}

class AssetCourseRepository implements CourseRepository {
  const AssetCourseRepository();

  @override
  Future<LearningPath> loadPath() async {
    final sources = await Future.wait([
      rootBundle.loadString('assets/content/java_path_fr.json'),
      rootBundle.loadString('assets/content/java_oop_fr.json'),
      rootBundle.loadString('assets/content/java_intermediate_fr.json'),
      rootBundle.loadString('assets/content/java_modern_fr.json'),
      rootBundle.loadString('assets/content/java_advanced_fr.json'),
      rootBundle.loadString('assets/content/java_professional_fr.json'),
      rootBundle.loadString('assets/content/java_backend_fr.json'),
    ]);
    final modules = <LearningModule>[];
    for (final source in sources) {
      modules.addAll(
        LearningPath.fromJson(
          jsonDecode(source) as Map<String, dynamic>,
        ).modules,
      );
    }
    return LearningPath(modules: modules);
  }
}

final courseRepositoryProvider = Provider<CourseRepository>(
  (ref) => const AssetCourseRepository(),
);

final learningPathProvider = FutureProvider<LearningPath>(
  (ref) => ref.watch(courseRepositoryProvider).loadPath(),
);

final lessonProvider = Provider.family<Lesson?, String>((ref, lessonId) {
  final path = ref.watch(learningPathProvider).valueOrNull;
  for (final module in path?.modules ?? const <LearningModule>[]) {
    for (final lesson in module.lessons) {
      if (lesson.id == lessonId) return lesson;
    }
  }
  return null;
});
