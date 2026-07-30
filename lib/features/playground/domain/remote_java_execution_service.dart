import 'dart:async';

import 'java_execution_service.dart';
import 'playground_models.dart';

class JavaSandboxPolicy {
  const JavaSandboxPolicy({
    this.timeout = const Duration(seconds: 5),
    this.maxCodeLength = 20000,
    this.maxOutputLength = 64000,
    this.memoryLimitMb = 128,
    this.cpuLimitMillis = 2000,
    this.networkAllowed = false,
    this.isolatedFileSystem = true,
  });

  final Duration timeout;
  final int maxCodeLength;
  final int maxOutputLength;
  final int memoryLimitMb;
  final int cpuLimitMillis;
  final bool networkAllowed;
  final bool isolatedFileSystem;
}

class RemoteExecutionRequest {
  const RemoteExecutionRequest({required this.code, required this.policy});

  final String code;
  final JavaSandboxPolicy policy;
}

abstract interface class RemoteJavaTransport {
  Future<JavaExecutionResult> send(RemoteExecutionRequest request);
}

class RemoteJavaExecutionService implements JavaExecutionService {
  const RemoteJavaExecutionService({
    required this.transport,
    this.policy = const JavaSandboxPolicy(),
  });

  final RemoteJavaTransport transport;
  final JavaSandboxPolicy policy;

  @override
  Future<JavaExecutionResult> execute(String code) async {
    if (code.trim().isEmpty) {
      return const JavaExecutionResult(
        status: JavaExecutionStatus.compilationError,
        output: 'Le code est vide.',
        isMock: false,
      );
    }
    if (code.length > policy.maxCodeLength) {
      return JavaExecutionResult(
        status: JavaExecutionStatus.compilationError,
        output:
            'Le code dépasse la limite de ${policy.maxCodeLength} caractères.',
        isMock: false,
      );
    }
    try {
      final result = await transport
          .send(RemoteExecutionRequest(code: code, policy: policy))
          .timeout(policy.timeout);
      final output = result.output.length <= policy.maxOutputLength
          ? result.output
          : '${result.output.substring(0, policy.maxOutputLength)}\n'
                '[Sortie tronquée]';
      return JavaExecutionResult(
        status: result.status,
        output: output,
        isMock: false,
      );
    } on TimeoutException {
      return const JavaExecutionResult(
        status: JavaExecutionStatus.unavailable,
        output: 'L’exécution a dépassé le délai autorisé.',
        isMock: false,
      );
    } on Object {
      return const JavaExecutionResult(
        status: JavaExecutionStatus.unavailable,
        output: 'Le service d’exécution sécurisé est indisponible.',
        isMock: false,
      );
    }
  }
}
