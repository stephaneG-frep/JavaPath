import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  test('une leçon terminée ajoute son XP une seule fois', () async {
    await database.completeLesson('variables', 10);
    await database.completeLesson('variables', 10);

    expect(await database.readProgressValue('xp'), 10);
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
}
