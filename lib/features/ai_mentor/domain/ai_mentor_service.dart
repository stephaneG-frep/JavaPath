enum MentorAuthor { user, mentor }

class MentorMessage {
  const MentorMessage({
    required this.author,
    required this.text,
    required this.createdAt,
    this.isLocalGuide = false,
  });

  final MentorAuthor author;
  final String text;
  final DateTime createdAt;
  final bool isLocalGuide;
}

enum MentorRequestType {
  explainConcept,
  explainCode,
  explainError,
  giveHint,
  simplify,
  createExercise,
  analyzeAnswer,
}

class MentorRequest {
  const MentorRequest({
    required this.message,
    required this.type,
    this.context,
  });

  final String message;
  final MentorRequestType type;
  final String? context;
}

abstract interface class AiMentorService {
  bool get isArtificialIntelligenceEnabled;
  Future<MentorMessage> respond(MentorRequest request);
}
