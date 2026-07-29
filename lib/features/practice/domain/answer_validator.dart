abstract final class AnswerValidator {
  static bool matches(String answer, List<String> acceptedAnswers) {
    final normalizedAnswer = _normalize(answer);
    return acceptedAnswers
        .map(_normalize)
        .any((accepted) => accepted == normalizedAnswer);
  }

  static String _normalize(String value) => value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll('é', 'e')
      .replaceAll('è', 'e');
}
