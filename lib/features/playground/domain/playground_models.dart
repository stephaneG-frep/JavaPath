class SavedCodeSnippet {
  const SavedCodeSnippet({
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

class ExecutionHistoryEntry {
  const ExecutionHistoryEntry({
    required this.id,
    required this.code,
    required this.output,
    required this.status,
    required this.executedAt,
  });

  final int id;
  final String code;
  final String output;
  final String status;
  final DateTime executedAt;
}

enum JavaExecutionStatus {
  success,
  compilationError,
  runtimeError,
  unavailable,
}

class JavaExecutionResult {
  const JavaExecutionResult({
    required this.status,
    required this.output,
    required this.isMock,
  });

  final JavaExecutionStatus status;
  final String output;
  final bool isMock;
}
