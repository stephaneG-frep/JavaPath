enum ExerciseType {
  completeCode,
  writeCode,
  multipleChoice,
  reorderLines,
  findError,
  predictOutput,
  matchConcept,
  fixProgram,
}

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.moduleIds,
  });
  final String id;
  final String title;
  final String description;
  final List<String> moduleIds;
}

class Quiz {
  const Quiz({required this.id, required this.questionIds, required this.xpReward});
  final String id;
  final List<String> questionIds;
  final int xpReward;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.choices,
    required this.correctChoiceIndex,
    required this.explanation,
    required this.conceptId,
  });
  final String id;
  final String prompt;
  final List<String> choices;
  final int correctChoiceIndex;
  final String explanation;
  final String conceptId;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    return QuizQuestion(
      id: id,
      prompt: json['prompt'] as String,
      choices: List<String>.from(json['choices'] as List<dynamic>),
      correctChoiceIndex: json['correctChoiceIndex'] as int,
      explanation: json['explanation'] as String,
      conceptId: json['conceptId'] as String? ?? _conceptForId(id),
    );
  }

  static String _conceptForId(String id) {
    final number = int.tryParse(id.split('-').last) ?? 0;
    return switch (number) {
      <= 3 => 'Environnement Java',
      <= 6 => 'Variables et types',
      <= 9 => 'Opérateurs',
      <= 11 => 'Conditions',
      <= 13 => 'Boucles',
      <= 16 => 'Tableaux',
      <= 19 => 'Méthodes',
      _ => 'Lisibilité du code',
    };
  }
}

class Exercise {
  const Exercise({
    required this.id,
    required this.conceptId,
    required this.type,
    required this.prompt,
    required this.difficulty,
    required this.xpReward,
    required this.hints,
    required this.solution,
    required this.explanation,
    this.choices = const [],
    this.acceptedAnswers = const [],
  });
  final String id;
  final String conceptId;
  final ExerciseType type;
  final String prompt;
  final String difficulty;
  final int xpReward;
  final List<String> hints;
  final String solution;
  final String explanation;
  final List<String> choices;
  final List<String> acceptedAnswers;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      conceptId: json['conceptId'] as String,
      type: ExerciseType.values.byName(json['type'] as String),
      prompt: json['prompt'] as String,
      difficulty: json['difficulty'] as String,
      xpReward: json['xpReward'] as int,
      hints: List<String>.from(json['hints'] as List<dynamic>),
      solution: json['solution'] as String,
      explanation: json['explanation'] as String,
      choices: List<String>.from(
        (json['choices'] as List<dynamic>?) ?? const [],
      ),
      acceptedAnswers: List<String>.from(
        (json['acceptedAnswers'] as List<dynamic>?) ?? const [],
      ),
    );
  }
}

class PracticeCatalog {
  const PracticeCatalog({
    required this.quizQuestions,
    required this.exercises,
  });
  final List<QuizQuestion> quizQuestions;
  final List<Exercise> exercises;

  factory PracticeCatalog.fromJson(Map<String, dynamic> json) {
    return PracticeCatalog(
      quizQuestions: (json['quizQuestions'] as List<dynamic>)
          .map((item) => QuizQuestion.fromJson(item as Map<String, dynamic>))
          .toList(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((item) => Exercise.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.code,
    required this.category,
    required this.prompt,
    required this.difficulty,
    required this.explanation,
    required this.xpReward,
    required this.hints,
    required this.acceptedAnswers,
    required this.solution,
    required this.partialSolution,
    required this.detailTitle,
    required this.detail,
    this.choices = const [],
  });
  final String id;
  final String title;
  final String code;
  final String category;
  final String prompt;
  final String difficulty;
  final String explanation;
  final int xpReward;
  final List<String> hints;
  final List<String> acceptedAnswers;
  final String solution;
  final String partialSolution;
  final String detailTitle;
  final String detail;
  final List<String> choices;

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String,
      category: json['category'] as String,
      prompt: json['prompt'] as String,
      difficulty: json['difficulty'] as String,
      explanation: json['explanation'] as String,
      xpReward: json['xpReward'] as int,
      hints: List<String>.from(json['hints'] as List<dynamic>),
      acceptedAnswers:
          List<String>.from(json['acceptedAnswers'] as List<dynamic>),
      solution: json['solution'] as String,
      partialSolution: json['partialSolution'] as String,
      detailTitle: json['detailTitle'] as String,
      detail: json['detail'] as String,
      choices:
          List<String>.from((json['choices'] as List<dynamic>?) ?? const []),
    );
  }
}

class LearningProject {
  const LearningProject({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.estimatedHours,
    required this.concepts,
    required this.missions,
    required this.xpReward,
  });
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final int estimatedHours;
  final List<String> concepts;
  final List<ProjectMission> missions;
  final int xpReward;

  factory LearningProject.fromJson(Map<String, dynamic> json) {
    return LearningProject(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      estimatedHours: json['estimatedHours'] as int,
      concepts: List<String>.from(json['concepts'] as List<dynamic>),
      missions: (json['missions'] as List<dynamic>)
          .map((item) => ProjectMission.fromJson(item as Map<String, dynamic>))
          .toList(),
      xpReward: json['xpReward'] as int,
    );
  }
}

class ProjectMission {
  const ProjectMission({
    required this.id,
    required this.title,
    required this.instructions,
    required this.order,
    required this.successCriteria,
    required this.starterCode,
  });
  final String id;
  final String title;
  final String instructions;
  final int order;
  final List<String> successCriteria;
  final String starterCode;

  factory ProjectMission.fromJson(Map<String, dynamic> json) {
    return ProjectMission(
      id: json['id'] as String,
      title: json['title'] as String,
      instructions: json['instructions'] as String,
      order: json['order'] as int,
      successCriteria:
          List<String>.from(json['successCriteria'] as List<dynamic>),
      starterCode: json['starterCode'] as String,
    );
  }
}

class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconKey,
  });
  final String id;
  final String title;
  final String description;
  final String iconKey;
}

class LearningSession {
  const LearningSession({
    required this.startedAt,
    required this.durationMinutes,
    this.lessonId,
  });
  final DateTime startedAt;
  final int durationMinutes;
  final String? lessonId;
}

class CodeSnippet {
  const CodeSnippet({
    required this.id,
    required this.title,
    required this.code,
    required this.updatedAt,
    required this.isFavorite,
  });
  final int id;
  final String title;
  final String code;
  final DateTime updatedAt;
  final bool isFavorite;
}

class ReviewItem {
  const ReviewItem({
    required this.id,
    required this.conceptId,
    required this.mastery,
    required this.nextReviewAt,
  });
  final String id;
  final String conceptId;
  final double mastery;
  final DateTime nextReviewAt;
}
