import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/ai_mentor/data/local_guided_mentor_service.dart';
import 'package:java_path/features/ai_mentor/domain/ai_mentor_service.dart';

void main() {
  test('le mentor local ne prétend pas utiliser une IA', () async {
    const service = LocalGuidedMentorService();

    final response = await service.respond(
      const MentorRequest(
        message: 'Pourquoi utilise-t-on private ?',
        type: MentorRequestType.explainConcept,
      ),
    );

    expect(service.isArtificialIntelligenceEnabled, isFalse);
    expect(response.isLocalGuide, isTrue);
    expect(response.text, contains('1. Explication simple'));
    expect(response.text, contains('2. Analogie'));
    expect(response.text, contains('3. Exemple Java'));
    expect(response.text, contains('4. Erreur fréquente'));
    expect(response.text, contains('5. Vérification'));
  });

  test('une notion inconnue reste transparente sur les limites', () async {
    const service = LocalGuidedMentorService();

    final response = await service.respond(
      const MentorRequest(
        message: 'Explique CompletableFuture',
        type: MentorRequestType.explainConcept,
      ),
    );

    expect(response.text, contains('IA n’est pas connecté'));
    expect(response.text, contains('Aucune donnée'));
  });
}
