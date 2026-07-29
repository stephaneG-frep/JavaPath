import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/java_execution_service.dart';
import '../domain/playground_models.dart';

abstract interface class PlaygroundRepository {
  Stream<List<SavedCodeSnippet>> watchSnippets();
  Future<int> saveSnippet(String title, String code);
  Future<void> toggleFavorite(int id, bool isFavorite);
  Stream<List<ExecutionHistoryEntry>> watchHistory();
  Future<int> recordExecution(JavaExecutionResult result, String code);
}

class DriftPlaygroundRepository implements PlaygroundRepository {
  const DriftPlaygroundRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<SavedCodeSnippet>> watchSnippets() {
    return _database.watchCodeSnippets().map(
          (rows) => rows
              .map(
                (row) => SavedCodeSnippet(
                  id: row.id,
                  title: row.title,
                  code: row.code,
                  updatedAt: row.updatedAt,
                  isFavorite: row.isFavorite,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<int> saveSnippet(String title, String code) =>
      _database.saveCodeSnippet(title, code);

  @override
  Future<void> toggleFavorite(int id, bool isFavorite) =>
      _database.toggleSnippetFavorite(id, isFavorite);

  @override
  Stream<List<ExecutionHistoryEntry>> watchHistory() {
    return _database.watchExecutionHistory().map(
          (rows) => rows
              .map(
                (row) => ExecutionHistoryEntry(
                  id: row.id,
                  code: row.code,
                  output: row.output,
                  status: row.status,
                  executedAt: row.executedAt,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<int> recordExecution(JavaExecutionResult result, String code) {
    return _database.recordExecution(
      code: code,
      output: result.output,
      status: result.status.name,
    );
  }
}

final javaExecutionServiceProvider = Provider<JavaExecutionService>(
  (ref) => const LocalMockExecutionService(),
);

final playgroundRepositoryProvider = Provider<PlaygroundRepository>(
  (ref) => DriftPlaygroundRepository(ref.watch(databaseProvider)),
);

final savedSnippetsProvider = StreamProvider<List<SavedCodeSnippet>>(
  (ref) => ref.watch(playgroundRepositoryProvider).watchSnippets(),
);

final executionHistoryProvider = StreamProvider<List<ExecutionHistoryEntry>>(
  (ref) => ref.watch(playgroundRepositoryProvider).watchHistory(),
);
