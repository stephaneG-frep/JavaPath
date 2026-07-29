import 'playground_models.dart';

abstract interface class JavaExecutionService {
  Future<JavaExecutionResult> execute(String code);
}

class LocalMockExecutionService implements JavaExecutionService {
  const LocalMockExecutionService();

  static const maxCodeLength = 20000;

  @override
  Future<JavaExecutionResult> execute(String code) async {
    if (code.length > maxCodeLength) {
      return const JavaExecutionResult(
        status: JavaExecutionStatus.unavailable,
        output: '[MODE DÉMONSTRATION]\n'
            'Le code dépasse la limite locale de 20 000 caractères.',
        isMock: true,
      );
    }
    return const JavaExecutionResult(
      status: JavaExecutionStatus.unavailable,
      output: '[MODE DÉMONSTRATION — AUCUNE JVM]\n'
          'JavaPath n’exécute pas encore le code Java sur ce téléphone.\n'
          'Aucune donnée n’a été envoyée sur Internet.\n\n'
          'Utilise le guide « Installer Java » pour exécuter ce programme '
          'sur un ordinateur. Une future API isolée pourra remplacer ce service.',
      isMock: true,
    );
  }
}
