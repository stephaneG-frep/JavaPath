import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le catalogue contient le contenu minimum de la phase pratique', () async {
    final source =
        await rootBundle.loadString('assets/content/practice_fr.json');
    final catalog = PracticeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );

    expect(catalog.quizQuestions, hasLength(20));
    expect(catalog.exercises, hasLength(10));
    expect(
      catalog.quizQuestions.every((question) => question.explanation.isNotEmpty),
      isTrue,
    );
    expect(
      catalog.exercises.every(
        (exercise) =>
            exercise.acceptedAnswers.isNotEmpty &&
            exercise.explanation.isNotEmpty,
      ),
      isTrue,
    );
  });
}
