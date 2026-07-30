import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';
import 'package:java_path/features/courses/domain/learning_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le niveau Backend Java contient 18 leçons réelles', () async {
    final source = await rootBundle.loadString(
      'assets/content/java_backend_fr.json',
    );
    final path = LearningPath.fromJson(
      jsonDecode(source) as Map<String, dynamic>,
    );
    final lessons = path.modules.expand((module) => module.lessons).toList();

    expect(path.modules, hasLength(4));
    expect(path.modules.every((module) => module.level == 7), isTrue);
    expect(lessons, hasLength(18));
    expect(
      lessons.every(
        (lesson) =>
            lesson.sections.length >= 3 && lesson.codeExamples.isNotEmpty,
      ),
      isTrue,
    );
    expect(
      path.modules.every((module) => module.projectId == 'api-rest-spring'),
      isTrue,
    );
  });

  test('la pratique Backend est guidée et expliquée', () async {
    final source = await rootBundle.loadString(
      'assets/content/practice_backend_fr.json',
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

  test('le projet final API REST contient huit missions', () async {
    final source = await rootBundle.loadString(
      'assets/content/projects_backend_fr.json',
    );
    final json = jsonDecode(source) as Map<String, dynamic>;
    final project = LearningProject.fromJson(
      (json['projects'] as List<dynamic>).single as Map<String, dynamic>,
    );

    expect(project.id, 'api-rest-spring');
    expect(project.xpReward, 300);
    expect(project.missions, hasLength(8));
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
