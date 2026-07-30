import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le niveau Java avancé contient 13 leçons réelles', () async {
    final source = await rootBundle.loadString(
      'assets/content/java_advanced_fr.json',
    );
    final path = LearningPath.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
    final lessons = path.modules.expand((module) => module.lessons).toList();

    expect(path.modules, hasLength(3));
    expect(path.modules.every((module) => module.level == 5), isTrue);
    expect(lessons, hasLength(13));
    expect(
      lessons.every(
        (lesson) =>
            lesson.sections.length >= 3 && lesson.codeExamples.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      path.modules.every((module) => module.projectId == 'java-multitache'),
      isTrue,
    );
  });

  test('la pratique avancée contient quiz et exercices guidés', () async {
    final source = await rootBundle.loadString(
      'assets/content/practice_advanced_fr.json',
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

  test('le projet multitâche contient six missions complètes', () async {
    final source = await rootBundle.loadString(
      'assets/content/projects_advanced_fr.json',
    );
    final json = jsonDecode(source) as Map<String, dynamic>;
    final project = LearningProject.fromJson(
      (json['projects'] as List<dynamic>).single as Map<String, dynamic>,
    );

    expect(project.id, 'java-multitache');
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
