import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/data/course_repository.dart';
import 'package:java_path/features/practice/data/challenge_repository.dart';
import 'package:java_path/features/practice/data/practice_repository.dart';
import 'package:java_path/features/projects/data/project_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'tous les catalogues fusionnés sont cohérents et sans doublon',
    () async {
      final path = await const AssetCourseRepository().loadPath();
      final practice = await const AssetPracticeRepository().loadCatalog();
      final challenges = await const AssetChallengeRepository().loadCatalog();
      final projects = await const AssetProjectRepository().loadProjects();

      final lessons = path.modules.expand((module) => module.lessons).toList();
      final projectById = {for (final project in projects) project.id: project};

      expect(path.modules, hasLength(22));
      expect(lessons, hasLength(98));
      expect(practice.quizQuestions, hasLength(80));
      expect(practice.exercises, hasLength(58));
      expect(challenges.debugChallenges, hasLength(5));
      expect(challenges.predictions, hasLength(5));
      expect(projects, hasLength(9));
      expect(projects.expand((project) => project.missions), hasLength(54));

      expect(path.modules.map((module) => module.id).toSet(), hasLength(22));
      expect(lessons.map((lesson) => lesson.id).toSet(), hasLength(98));
      expect(
        practice.quizQuestions.map((question) => question.id).toSet(),
        hasLength(80),
      );
      expect(
        practice.exercises.map((exercise) => exercise.id).toSet(),
        hasLength(58),
      );
      expect(projects.map((project) => project.id).toSet(), hasLength(9));

      expect(
        path.modules.every(
          (module) =>
              module.projectId != null &&
              projectById.containsKey(module.projectId) &&
              projectById[module.projectId]!.title == module.projectTitle &&
              module.lessons.every((lesson) => lesson.moduleId == module.id),
        ),
        isTrue,
      );
      expect(
        path.modules.map((module) => module.level).toSet(),
        equals({1, 2, 3, 4, 5, 6, 7}),
      );
    },
  );
}
