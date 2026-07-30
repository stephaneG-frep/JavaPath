import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le niveau intermédiaire contient 14 leçons réelles', () async {
    final source = await rootBundle.loadString(
      'assets/content/java_intermediate_fr.json',
    );
    final path = LearningPath.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
    final lessons = path.modules.expand((module) => module.lessons).toList();

    expect(path.modules, hasLength(3));
    expect(path.modules.every((module) => module.level == 3), isTrue);
    expect(lessons, hasLength(14));
    expect(
      lessons.every(
        (lesson) =>
            lesson.sections.length >= 3 && lesson.codeExamples.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      path.modules.every((module) => module.projectId == 'contacts'),
      isTrue,
    );
  });

  test('la pratique intermédiaire est complète et expliquée', () async {
    final source = await rootBundle.loadString(
      'assets/content/practice_intermediate_fr.json',
    );
    final catalog = PracticeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );

    expect(catalog.quizQuestions, hasLength(10));
    expect(catalog.exercises, hasLength(8));
    expect(
      catalog.quizQuestions.every(
        (question) => question.explanation.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      catalog.exercises.every(
        (exercise) =>
            exercise.hints.length >= 2 &&
            exercise.acceptedAnswers.isNotEmpty &&
            exercise.explanation.isNotEmpty,
      ),
      isTrue,
    );
  });
}
