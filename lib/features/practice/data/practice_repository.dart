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
    final source =
        await rootBundle.loadString('assets/content/practice_fr.json');
    return PracticeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
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
