import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le niveau professionnel contient 15 leçons réelles', () async {
    final source = await rootBundle.loadString(
      'assets/content/java_professional_fr.json',
    );
    final path = LearningPath.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
    final lessons = path.modules.expand((module) => module.lessons).toList();

    expect(path.modules, hasLength(3));
    expect(path.modules.every((module) => module.level == 6), isTrue);
    expect(lessons, hasLength(15));
    expect(
      lessons.every(
        (lesson) =>
            lesson.sections.length >= 3 && lesson.codeExamples.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      path.modules.every(
        (module) => module.projectId == 'java-professionnelle',
      ),
      isTrue,
    );
  });

  test('la pratique professionnelle est guidée et expliquée', () async {
    final source = await rootBundle.loadString(
      'assets/content/practice_professional_fr.json',
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

  test('le projet professionnel contient sept missions complètes', () async {
    final source = await rootBundle.loadString(
      'assets/content/projects_professional_fr.json',
    );
    final json = jsonDecode(source) as Map<String, dynamic>;
    final project = LearningProject.fromJson(
      (json['projects'] as List<dynamic>).single as Map<String, dynamic>,
    );

    expect(project.id, 'java-professionnelle');
    expect(project.missions, hasLength(7));
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
