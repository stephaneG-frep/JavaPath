import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../courses/domain/activity_models.dart';

class ChallengeCatalog {
  const ChallengeCatalog({
    required this.debugChallenges,
    required this.predictions,
  });

  final List<Challenge> debugChallenges;
  final List<Challenge> predictions;

  factory ChallengeCatalog.fromJson(Map<String, dynamic> json) {
    List<Challenge> read(String key) => (json[key] as List<dynamic>)
        .map((item) => Challenge.fromJson(item as Map<String, dynamic>))
        .toList();
    return ChallengeCatalog(
      debugChallenges: read('debugChallenges'),
      predictions: read('predictions'),
    );
  }
}

abstract interface class ChallengeRepository {
  Future<ChallengeCatalog> loadCatalog();
}

class AssetChallengeRepository implements ChallengeRepository {
  const AssetChallengeRepository();

  @override
  Future<ChallengeCatalog> loadCatalog() async {
    final source =
        await rootBundle.loadString('assets/content/challenges_fr.json');
    return ChallengeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}

final challengeRepositoryProvider = Provider<ChallengeRepository>(
  (ref) => const AssetChallengeRepository(),
);

final challengeCatalogProvider = FutureProvider<ChallengeCatalog>(
  (ref) => ref.watch(challengeRepositoryProvider).loadCatalog(),
);

final challengeProvider = Provider.family<Challenge?, String>((ref, id) {
  final catalog = ref.watch(challengeCatalogProvider).valueOrNull;
  final activities = [
    ...?catalog?.debugChallenges,
    ...?catalog?.predictions,
  ];
  for (final challenge in activities) {
    if (challenge.id == id) return challenge;
  }
  return null;
});
