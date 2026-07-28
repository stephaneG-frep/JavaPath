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
  });
  final String id;
  final String prompt;
  final List<String> choices;
  final int correctChoiceIndex;
  final String explanation;
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
}

class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.code,
    required this.category,
    required this.explanation,
    required this.xpReward,
  });
  final String id;
  final String title;
  final String code;
  final String category;
  final String explanation;
  final int xpReward;
}

class LearningProject {
  const LearningProject({
    required this.id,
    required this.title,
    required this.description,
    required this.missions,
    required this.xpReward,
  });
  final String id;
  final String title;
  final String description;
  final List<ProjectMission> missions;
  final int xpReward;
}

class ProjectMission {
  const ProjectMission({
    required this.id,
    required this.title,
    required this.instructions,
    required this.order,
  });
  final String id;
  final String title;
  final String instructions;
  final int order;
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
