import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/playground/domain/java_execution_service.dart';
import 'package:java_path/features/playground/domain/playground_models.dart';

void main() {
  test('le service local annonce clairement qu’il est mock', () async {
    const service = LocalMockExecutionService();

    final result = await service.execute(
      'System.out.println("Bonjour");',
    );

    expect(result.isMock, isTrue);
    expect(result.status, JavaExecutionStatus.unavailable);
    expect(result.output, contains('AUCUNE JVM'));
    expect(result.output, contains('Aucune donnée'));
  });

  test('refuse un code dépassant la limite locale', () async {
    const service = LocalMockExecutionService();

    final result = await service.execute(
      List.filled(LocalMockExecutionService.maxCodeLength + 1, 'a').join(),
    );

    expect(result.status, JavaExecutionStatus.unavailable);
    expect(result.output, contains('20 000 caractères'));
  });
}
