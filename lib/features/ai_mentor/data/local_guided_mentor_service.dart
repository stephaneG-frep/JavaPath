import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/ai_mentor_service.dart';

class LocalGuidedMentorService implements AiMentorService {
  const LocalGuidedMentorService();

  @override
  bool get isArtificialIntelligenceEnabled => false;

  @override
  Future<MentorMessage> respond(MentorRequest request) async {
    final message = request.message.toLowerCase();
    final response = switch (message) {
      final text when text.contains('private') => _privateExplanation,
      final text when text.contains('variable') => _variableExplanation,
      final text when text.contains('boucle') || text.contains('for') =>
        _loopExplanation,
      final text when text.contains('null') => _nullExplanation,
      _ => _fallback,
    };
    return MentorMessage(
      author: MentorAuthor.mentor,
      text: response,
      createdAt: DateTime.now(),
      isLocalGuide: true,
    );
  }

  static const _privateExplanation = '''
1. Explication simple
private empêche le reste du programme d’accéder directement à un élément d’une classe.

2. Analogie
Imagine un distributeur : son mécanisme reste fermé, mais les boutons publics permettent de l’utiliser sans le casser.

3. Exemple Java
class Compte {
  private double solde;

  public double getSolde() {
    return solde;
  }
}

4. Erreur fréquente
Rendre tous les attributs public permet de leur donner n’importe quelle valeur sans contrôle.

5. Vérification
Pourquoi getSolde() peut-il être public alors que solde reste private ?''';

  static const _variableExplanation = '''
1. Explication simple
Une variable est un emplacement nommé qui conserve une valeur.

2. Analogie
C’est une boîte portant une étiquette : l’étiquette est le nom et le contenu est la valeur.

3. Exemple Java
int age = 25;
System.out.println(age);

4. Erreur fréquente
La valeur doit correspondre au type : int age = "25"; est incorrect.

5. Vérification
Quel type choisirais-tu pour mémoriser un prénom ?''';

  static const _loopExplanation = '''
1. Explication simple
Une boucle répète un bloc tant qu’une condition l’autorise.

2. Analogie
Comme monter un escalier : tu avances marche après marche jusqu’à atteindre l’étage.

3. Exemple Java
for (int i = 0; i < 3; i++) {
  System.out.println(i);
}

4. Erreur fréquente
Oublier de rapprocher le compteur de la limite peut créer une boucle infinie.

5. Vérification
Quelles valeurs de i seront affichées dans cet exemple ?''';

  static const _nullExplanation = '''
1. Explication simple
null signifie qu’une variable ne référence actuellement aucun objet.

2. Analogie
C’est une adresse vide : essayer d’y ouvrir une porte est impossible.

3. Exemple Java
String nom = null;
if (nom != null) {
  System.out.println(nom.length());
}

4. Erreur fréquente
Appeler nom.length() sans vérification peut provoquer une NullPointerException.

5. Vérification
Que garantit la condition nom != null ?''';

  static const _fallback = '''
Le mentor IA n’est pas connecté dans cette version.

Je suis actuellement un guide local hors ligne. Je peux expliquer :
• les variables ;
• les boucles for ;
• private et l’encapsulation ;
• null et NullPointerException.

Pour une autre notion, consulte le parcours ou reformule avec l’un de ces mots-clés. Aucune donnée n’a été envoyée sur Internet.''';
}

final aiMentorServiceProvider = Provider<AiMentorService>(
  (ref) => const LocalGuidedMentorService(),
);
