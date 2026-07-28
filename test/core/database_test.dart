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
}
