import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le niveau Java moderne contient 11 leçons réelles', () async {
    final source = await rootBundle.loadString(
      'assets/content/java_modern_fr.json',
    );
    final path = LearningPath.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
    final lessons = path.modules.expand((module) => module.lessons).toList();

    expect(path.modules, hasLength(3));
    expect(path.modules.every((module) => module.level == 4), isTrue);
    expect(lessons, hasLength(11));
    expect(
      lessons.every(
        (lesson) =>
            lesson.sections.length >= 3 && lesson.codeExamples.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      path.modules.every((module) => module.projectId == 'analyseur-donnees'),
      isTrue,
    );
  });

  test('la pratique Java moderne contient quiz et exercices guidés', () async {
    final source = await rootBundle.loadString(
      'assets/content/practice_modern_fr.json',
    );
    final catalog = PracticeCatalog.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );

    expect(catalog.quizQuestions, hasLength(10));
    expect(catalog.exercises, hasLength(8));
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

  test('le projet Analyseur de données possède six missions', () async {
    final source = await rootBundle.loadString(
      'assets/content/projects_modern_fr.json',
    );
    final json = jsonDecode(source) as Map<String, dynamic>;
    final project = LearningProject.fromJson(
      (json['projects'] as List<dynamic>).single as Map<String, dynamic>,
    );

    expect(project.id, 'analyseur-donnees');
    expect(project.missions, hasLength(6));
    expect(
      project.missions.every(
        (mission) =>
            mission.successCriteria.isNotEmpty &&
            mission.starterCode.isNotEmpty,
      ),
      isTrue,
    );
  });
}
