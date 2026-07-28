# JavaPath

Application Flutter offline-first pour apprendre Java progressivement, du premier
programme aux pratiques professionnelles.

## Phase livrée

Cette base comprend :

- onboarding et préférences de profil ;
- navigation Material 3 à cinq destinations ;
- thèmes clair, sombre et système ;
- dashboard avec progression XP ;
- parcours pédagogique alimenté par un fichier JSON français ;
- 3 modules et 10 leçons Java réelles ;
- stockage Drift de la progression, des sessions et des futurs snippets ;
- modèles de domaine pour les futures phases ;
- tests du calcul de niveau, de la persistance XP et de l’onboarding.

Les exercices, projets, playground et services IA ne sont pas implémentés dans
cette phase. Leurs emplacements sont visibles et explicitement signalés dans
l’interface.

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
