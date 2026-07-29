import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/playground/domain/playground_models.dart';
import 'package:java_path/features/playground/domain/remote_java_execution_service.dart';

class _RecordingTransport implements RemoteJavaTransport {
  RemoteExecutionRequest? request;

  @override
  Future<JavaExecutionResult> send(RemoteExecutionRequest request) async {
    this.request = request;
    return const JavaExecutionResult(
      status: JavaExecutionStatus.success,
      output: 'Bonjour',
      isMock: false,
    );
  }
}

void main() {
  test('transmet une politique de sandbox restrictive', () async {
    final transport = _RecordingTransport();
    final service = RemoteJavaExecutionService(transport: transport);

    final result = await service.execute('class Main {}');

    expect(result.status, JavaExecutionStatus.success);
    expect(transport.request?.policy.networkAllowed, isFalse);
    expect(transport.request?.policy.isolatedFileSystem, isTrue);
    expect(transport.request?.policy.memoryLimitMb, 128);
    expect(transport.request?.policy.cpuLimitMillis, 2000);
  });

  test('refuse le code trop volumineux avant tout transport', () async {
    final transport = _RecordingTransport();
    final service = RemoteJavaExecutionService(
      transport: transport,
      policy: const JavaSandboxPolicy(maxCodeLength: 5),
    );

    final result = await service.execute('class Main {}');

    expect(result.status, JavaExecutionStatus.compilationError);
    expect(transport.request, isNull);
  });
}
