import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mode d’emploi & aide')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.waving_hand_rounded, size: 38),
                  const SizedBox(height: 12),
                  Text(
                    'Bienvenue dans JavaPath',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Apprends une notion, observe un exemple, puis entraîne-toi. '
                    'Tu peux avancer à ton rythme : aucune connaissance préalable '
                    'n’est nécessaire.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.all(18),
              onTap: () => context.push('/help/java-setup'),
              leading: const Icon(Icons.download_done_rounded, size: 38),
              title: const Text(
                'Installer tout ce qu’il faut',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: const Text(
                'JDK, éditeur, vérification et premier programme sur ordinateur',
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Démarrage rapide',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          const _StepTile(
            number: 1,
            title: 'Choisis une leçon',
            description:
                'Ouvre Apprendre, puis commence par la première leçon disponible.',
          ),
          const _StepTile(
            number: 2,
            title: 'Lis et observe le code',
            description:
                'Chaque exemple est accompagné d’une explication simple et progressive.',
          ),
          const _StepTile(
            number: 3,
            title: 'Termine la leçon',
            description:
                'Le bouton en bas enregistre la leçon et ajoute son XP une seule fois.',
          ),
          const _StepTile(
            number: 4,
            title: 'Passe à la pratique',
            description:
                'Utilise les quiz, exercices, prédictions et challenges de débogage.',
          ),
          const SizedBox(height: 24),
          Text(
            'Comprendre l’application',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const _HelpSection(
            icon: Icons.home_rounded,
            title: 'Accueil',
            children: [
              'Retrouve ta prochaine leçon, ton niveau et tes raccourcis.',
              'La barre d’XP indique ta progression vers le niveau suivant.',
              'Les compteurs résument tes leçons et exercices terminés.',
            ],
          ),
          const _HelpSection(
            icon: Icons.school_rounded,
            title: 'Apprendre',
            children: [
              'Les modules sont organisés dans un ordre progressif.',
              'Appuie sur une leçon pour lire son explication et ses exemples.',
              'Une leçon déjà terminée ne rapporte pas deux fois son XP.',
            ],
          ),
          const _HelpSection(
            icon: Icons.fitness_center_rounded,
            title: 'Pratiquer',
            children: [
              'Quiz : choisis une réponse, valide, puis lis l’explication.',
              'Exercices : écris ou sélectionne la partie demandée.',
              'Prédiction : imagine l’exécution du programme avant de répondre.',
              'Debug Challenge : localise l’erreur et comprends comment l’éviter.',
            ],
          ),
          const _HelpSection(
            icon: Icons.lightbulb_rounded,
            title: 'Indices et solutions',
            children: [
              'Commence toujours par essayer seul.',
              'Chaque indice utilisé réduit la récompense de 5 XP.',
              'La solution partielle donne une direction sans tout dévoiler.',
              'Voir la solution complète annule l’XP de cette activité, mais tu peux toujours répondre pour apprendre.',
            ],
          ),
          const _HelpSection(
            icon: Icons.bolt_rounded,
            title: 'XP et niveaux',
            children: [
              'Les leçons, quiz, exercices et challenges rapportent de l’XP.',
              'Une activité ne rapporte son XP que lors de sa première réussite.',
              'Accumuler de l’XP fait progresser ton niveau JavaPath.',
            ],
          ),
          const _HelpSection(
            icon: Icons.offline_bolt_rounded,
            title: 'Utilisation hors ligne',
            children: [
              'Les cours et activités actuels sont inclus dans l’application.',
              'Ta progression est enregistrée localement sur cet appareil.',
              'Désinstaller l’application peut supprimer les données locales.',
            ],
          ),
          const _HelpSection(
            icon: Icons.construction_rounded,
            title: 'Fonctionnalités à venir',
            children: [
              'Les projets guidés, le playground Java et le mentor IA seront ajoutés dans de prochaines phases.',
              'Le playground n’exécute pas encore de code Java.',
              'JavaPath ne prétend donc pas compiler un programme tant que le service sécurisé n’est pas disponible.',
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Conseil : quinze minutes régulières sont souvent plus '
                      'efficaces qu’une longue session occasionnelle.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, child: Text('$number')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpSection extends StatelessWidget {
  const _HelpSection({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in children)
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, size: 6),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
