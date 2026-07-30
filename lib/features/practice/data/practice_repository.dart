import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../courses/domain/activity_models.dart';

abstract interface class PracticeRepository {
  Future<PracticeCatalog> loadCatalog();
}

class AssetPracticeRepository implements PracticeRepository {
  const AssetPracticeRepository();

  @override
  Future<PracticeCatalog> loadCatalog() async {
    final sources = await Future.wait([
      rootBundle.loadString('assets/content/practice_fr.json'),
      rootBundle.loadString('assets/content/practice_oop_fr.json'),
      rootBundle.loadString('assets/content/practice_intermediate_fr.json'),
      rootBundle.loadString('assets/content/practice_modern_fr.json'),
    ]);
    final questions = <QuizQuestion>[];
    final exercises = <Exercise>[];
    for (final source in sources) {
      final catalog = PracticeCatalog.fromJson(
        jsonDecode(source) as Map<String, dynamic>,
      );
      questions.addAll(catalog.quizQuestions);
      exercises.addAll(catalog.exercises);
    }
    return PracticeCatalog(
      quizQuestions: questions,
      exercises: exercises,
    );
  }
}

final practiceRepositoryProvider = Provider<PracticeRepository>(
  (ref) => const AssetPracticeRepository(),
);

final practiceCatalogProvider = FutureProvider<PracticeCatalog>(
  (ref) => ref.watch(practiceRepositoryProvider).loadCatalog(),
);

final exerciseProvider = Provider.family<Exercise?, String>((ref, id) {
  final catalog = ref.watch(practiceCatalogProvider).valueOrNull;
  for (final exercise in catalog?.exercises ?? const <Exercise>[]) {
    if (exercise.id == id) return exercise;
  }
  return null;
});
