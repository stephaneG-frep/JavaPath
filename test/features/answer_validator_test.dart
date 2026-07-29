import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/practice/domain/answer_validator.dart';

void main() {
  test('ignore la casse et les espaces superflus', () {
    expect(
      AnswerValidator.matches('  RETURN   somme; ', ['return somme;']),
      isTrue,
    );
  });

  test('refuse une réponse différente', () {
    expect(AnswerValidator.matches('14', ['13']), isFalse);
  });
}
