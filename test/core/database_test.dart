import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  test('une leçon terminée ajoute son XP une seule fois', () async {
    await database.completeLesson('variables', 10, 12);
    await database.completeLesson('variables', 10, 12);

    expect(await database.readProgressValue('xp'), 10);
    expect(await database.readProgressValue('learning_minutes'), 12);
    expect(await database.readProgressValue('current_streak'), 1);
    expect(await database.watchCompletedLessons().first, hasLength(1));
  });

  test('un exercice validé ajoute son XP une seule fois', () async {
    final first = await database.completeActivity(
      activityId: 'exercise-01',
      activityType: 'exercise',
      xp: 30,
    );
    final second = await database.completeActivity(
      activityId: 'exercise-01',
      activityType: 'exercise',
      xp: 30,
    );

    expect(first, isTrue);
    expect(second, isFalse);
    expect(await database.readProgressValue('xp'), 30);
    expect(await database.readProgressValue('completed_exercises'), 1);
  });

  test('les tentatives et indices sont persistés', () async {
    await database.recordAttempt('debug-01', 'debug');
    await database.recordAttempt('debug-01', 'debug');
    await database.revealHint('debug-01', 'debug', 1);
    await database.viewSolution('debug-01', 'debug');

    final state = await database.readActivityState('debug-01', 'debug');
    expect(state?.attempts, 2);
    expect(state?.hintsUsed, 1);
    expect(state?.solutionViewed, isTrue);
  });

  test('seul le projet terminé crédite 200 XP', () async {
    await database.completeActivity(
      activityId: 'nombre-mystere:structure',
      activityType: 'project_mission',
      xp: 0,
    );
    expect(await database.readProgressValue('xp'), 0);
    expect(await database.readProgressValue('completed_projects'), 0);

    await database.completeActivity(
      activityId: 'nombre-mystere',
      activityType: 'project',
      xp: 200,
    );
    await database.completeActivity(
      activityId: 'nombre-mystere',
      activityType: 'project',
      xp: 200,
    );

    expect(await database.readProgressValue('xp'), 200);
    expect(await database.readProgressValue('completed_projects'), 1);
  });

  test('sauvegarde un snippet favori et une entrée d’historique', () async {
    final snippetId = await database.saveCodeSnippet(
      'Bonjour',
      'System.out.println("Bonjour");',
    );
    await database.toggleSnippetFavorite(snippetId, true);
    final snippets = await database.watchCodeSnippets().first;

    expect(snippets, hasLength(1));
    expect(snippets.first.isFavorite, isTrue);

    await database.recordExecution(
      code: snippets.first.code,
      output: 'Mode démonstration',
      status: 'unavailable',
    );
    final history = await database.watchExecutionHistory().first;
    expect(history, hasLength(1));
    expect(history.first.status, 'unavailable');
  });

  test('enregistre une faiblesse puis espace sa révision', () async {
    await database.recordReviewError('Boucles');
    var review = (await database.watchReviewRecords().first).single;
    expect(review.errorCount, 1);
    expect(review.successCount, 0);

    await database.recordReviewSuccess('Boucles');
    review = (await database.watchReviewRecords().first).single;
    expect(review.successCount, 1);
    expect(review.nextReviewDay, review.lastReviewDay + 1);
  });
}
