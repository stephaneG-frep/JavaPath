# JavaPath

Application Flutter offline-first pour apprendre Java progressivement, du premier
programme aux pratiques professionnelles.

## Version 1.0 — MVP complet

Cette version comprend :

- onboarding et préférences de profil ;
- navigation Material 3 à cinq destinations ;
- thèmes clair, sombre et système ;
- dashboard avec progression XP ;
- parcours pédagogique alimenté par un fichier JSON français ;
- 22 modules et 98 leçons Java réelles, des fondamentaux au backend Spring ;
- 80 questions de quiz avec correction expliquée ;
- 58 exercices validés localement avec attribution d’XP ;
- 5 Debug Challenges et 5 exercices de prédiction ;
- indices progressifs avec réduction transparente de l’XP ;
- 9 projets Java découpés en 54 missions guidées ;
- playground avec coloration Java, snippets, favoris et historique ;
- badges, séries protégées, statistiques et révisions espacées ;
- Java Mentor local et contrats pour l’IA, l’exécution distante et la synchronisation ;
- stockage Drift de la progression, des sessions et des futurs snippets ;
- profil personnalisable avec taille de texte accessible ;
- contrôles d’intégrité de l’ensemble des catalogues ;
- tests du calcul de niveau, de la persistance XP et de l’onboarding.

Le playground fonctionne volontairement en mode démonstration local : aucune JVM
n’est intégrée dans l’application mobile. Le mentor est un guide pédagogique
local. Les contrats d’exécution distante et d’IA sont prêts, mais aucun service
réseau ni aucune clé secrète ne sont inclus dans ce MVP.

## Architecture

```text
lib/
├── core/
│   ├── database/       # Schéma Drift et provider
│   ├── router/         # Routes GoRouter et shell
│   ├── services/       # Préférences simples
│   ├── theme/          # Thèmes Material 3
│   └── widgets/        # Composants transversaux
└── features/
    ├── onboarding/
    ├── home/
    ├── courses/        # data / domain / presentation
    ├── practice/       # quiz, exercices et validation
    ├── progress/       # data / domain
    ├── profile/
    ├── shell/
    └── common/
assets/content/         # Contenu pédagogique indépendant de l’UI
```

Riverpod gère l’état et l’injection des dépendances. GoRouter gère le shell et
les redirections d’onboarding. Drift conserve les données métier structurées ;
SharedPreferences est limité aux préférences simples.

## Lancer le projet

Prérequis : Flutter stable configuré avec au moins une cible.

```bash
flutter pub get
dart run build_runner build
flutter run
```

Pour contrôler la qualité :

```bash
flutter analyze
flutter test
flutter build apk --debug
```

Pour produire l’APK local optimisé :

```bash
flutter build apk --release
```

Le fichier est généré dans `build/app/outputs/flutter-apk/`. La configuration
actuelle utilise une signature locale de préproduction afin de permettre les
tests sur appareil. Une clé privée dédiée devra être configurée avant toute
publication sur un store.
