import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/practice/data/challenge_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le catalogue contient les challenges attendus', () async {
    final source =
        await rootBundle.loadString('assets/content/challenges_fr.json');
    final catalog = ChallengeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );

    expect(catalog.debugChallenges, hasLength(5));
    expect(catalog.predictions, hasLength(5));
    expect(
      [...catalog.debugChallenges, ...catalog.predictions].every(
        (challenge) =>
            challenge.hints.length >= 2 &&
            challenge.solution.isNotEmpty &&
            challenge.explanation.isNotEmpty,
      ),
      isTrue,
    );
  });
}
