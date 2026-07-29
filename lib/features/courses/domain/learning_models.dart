enum LessonDifficulty { debutant, intermediaire, avance }

class LearningPath {
  const LearningPath({required this.modules});
  final List<LearningModule> modules;

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      modules: (json['modules'] as List<dynamic>)
          .map((item) => LearningModule.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LearningModule {
  const LearningModule({
    required this.id,
    required this.level,
    required this.title,
    required this.description,
    required this.projectTitle,
    required this.lessons,
    this.projectId,
  });

  final String id;
  final int level;
  final String title;
  final String description;
  final String projectTitle;
  final String? projectId;
  final List<Lesson> lessons;

  factory LearningModule.fromJson(Map<String, dynamic> json) {
    return LearningModule(
      id: json['id'] as String,
      level: json['level'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      projectTitle: json['projectTitle'] as String,
      projectId: json['projectId'] as String?,
      lessons: (json['lessons'] as List<dynamic>)
          .map((item) => Lesson.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Lesson {
  const Lesson({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.xpReward,
    required this.sections,
    required this.codeExamples,
  });

  final String id;
  final String moduleId;
  final String title;
  final String description;
  final LessonDifficulty difficulty;
  final int estimatedMinutes;
  final int xpReward;
  final List<LessonSection> sections;
  final List<CodeExample> codeExamples;

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      moduleId: json['moduleId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      difficulty: LessonDifficulty.values.byName(json['difficulty'] as String),
      estimatedMinutes: json['estimatedMinutes'] as int,
      xpReward: json['xpReward'] as int,
      sections: (json['sections'] as List<dynamic>)
          .map((item) => LessonSection.fromJson(item as Map<String, dynamic>))
          .toList(),
      codeExamples: (json['codeExamples'] as List<dynamic>)
          .map((item) => CodeExample.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LessonSection {
  const LessonSection({required this.title, required this.content});
  final String title;
  final String content;

  factory LessonSection.fromJson(Map<String, dynamic> json) {
    return LessonSection(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

class CodeExample {
  const CodeExample({
    required this.title,
    required this.code,
    required this.explanation,
  });
  final String title;
  final String code;
  final String explanation;

  factory CodeExample.fromJson(Map<String, dynamic> json) {
    return CodeExample(
      title: json['title'] as String,
      code: json['code'] as String,
      explanation: json['explanation'] as String,
    );
  }
}
