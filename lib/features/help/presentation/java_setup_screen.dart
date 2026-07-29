import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/widgets/code_block.dart';

class JavaSetupScreen extends StatelessWidget {
  const JavaSetupScreen({super.key});

  static const _adoptiumUrl = 'https://adoptium.net/temurin/releases/';
  static const _vscodeUrl = 'https://code.visualstudio.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Installer Java')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.computer_rounded, size: 38),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Faut-il installer quelque chose ?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Pour suivre les cours dans JavaPath sur ton téléphone : '
                          'non. Pour créer et exécuter de vrais programmes Java : '
                          'oui, il faut préparer un ordinateur.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _RequirementCard(
            icon: Icons.check_circle_outline_rounded,
            title: 'Ce qu’il faut installer',
            items: [
              'Un JDK : il contient Java, la JVM et le compilateur javac.',
              'Un éditeur : Visual Studio Code convient très bien pour débuter.',
              'L’Extension Pack for Java dans Visual Studio Code.',
              'Git, Maven et Gradle ne sont pas nécessaires pour les premières leçons.',
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle(number: 1, title: 'Installer le JDK 25 LTS'),
          const SizedBox(height: 10),
          const Text(
            'Choisis le paquet JDK, et non JRE. Le JDK permet de compiler et '
            'développer ; le JRE seul sert principalement à exécuter.',
          ),
          const SizedBox(height: 12),
          _CopyAddressCard(
            label: 'Téléchargement officiel Eclipse Temurin',
            address: _adoptiumUrl,
          ),
          const SizedBox(height: 12),
          const _PlatformGuide(
            title: 'Windows',
            icon: Icons.window_rounded,
            steps: [
              'Sur la page Temurin, sélectionne JDK 25 LTS, Windows et ton architecture.',
              'Télécharge le fichier .msi puis ouvre-le.',
              'Pendant l’installation, active les options JAVA_HOME et Add to PATH si elles sont proposées.',
              'Termine l’installation puis ferme et rouvre le terminal.',
            ],
          ),
          const _PlatformGuide(
            title: 'macOS',
            icon: Icons.laptop_mac_rounded,
            steps: [
              'Choisis macOS et la bonne architecture : AArch64 pour Apple Silicon, x64 pour un ancien Mac Intel.',
              'Télécharge le fichier .pkg et suis l’assistant.',
              'Ferme et rouvre le Terminal après l’installation.',
            ],
          ),
          const _PlatformGuide(
            title: 'Linux',
            icon: Icons.computer_rounded,
            steps: [
              'Choisis Linux et ton architecture sur le site Temurin.',
              'Utilise de préférence les instructions officielles DEB ou RPM adaptées à ta distribution.',
              'Le nom du paquet actuel est temurin-25-jdk.',
              'Rouvre le terminal une fois l’installation terminée.',
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle(number: 2, title: 'Vérifier Java'),
          const SizedBox(height: 10),
          const Text(
            'Ouvre PowerShell sous Windows, ou Terminal sous macOS/Linux, puis '
            'exécute ces deux commandes :',
          ),
          const SizedBox(height: 12),
          const CodeBlock(code: 'java --version\njavac --version'),
          const SizedBox(height: 10),
          const Text(
            'Les deux commandes doivent afficher une version. Si java fonctionne '
            'mais pas javac, un JRE a probablement été installé à la place du JDK.',
          ),
          const SizedBox(height: 24),
          const _SectionTitle(number: 3, title: 'Installer l’éditeur'),
          const SizedBox(height: 10),
          _CopyAddressCard(
            label: 'Télécharger Visual Studio Code',
            address: _vscodeUrl,
          ),
          const SizedBox(height: 12),
          const _RequirementCard(
            icon: Icons.extension_rounded,
            title: 'Dans Visual Studio Code',
            items: [
              'Ouvre le panneau Extensions.',
              'Recherche « Extension Pack for Java ».',
              'Vérifie que l’éditeur est Microsoft, puis installe le pack.',
              'Redémarre Visual Studio Code si Java n’est pas détecté immédiatement.',
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle(number: 4, title: 'Créer le premier programme'),
          const SizedBox(height: 10),
          const Text(
            'Crée un dossier JavaPath, ouvre-le dans l’éditeur, puis crée un '
            'fichier nommé Main.java avec ce contenu :',
          ),
          const SizedBox(height: 12),
          const CodeBlock(
            code: 'public class Main {\n'
                '  public static void main(String[] args) {\n'
                '    System.out.println("Bonjour Java !");\n'
                '  }\n'
                '}',
          ),
          const SizedBox(height: 12),
          const Text('Dans le terminal ouvert dans ce dossier :'),
          const SizedBox(height: 10),
          const CodeBlock(code: 'javac Main.java\njava Main'),
          const SizedBox(height: 10),
          const Text(
            'javac compile le fichier et crée Main.class. La commande java Main '
            'lance ensuite le programme, qui doit afficher « Bonjour Java ! ».',
          ),
          const SizedBox(height: 24),
          const _SectionTitle(number: 5, title: 'En cas de problème'),
          const SizedBox(height: 10),
          const _TroubleshootingTile(
            problem: '« java » ou « javac » n’est pas reconnu',
            solution:
                'Ferme et rouvre le terminal. Si le problème continue, réinstalle '
                'le JDK en activant JAVA_HOME et l’ajout au PATH.',
          ),
          const _TroubleshootingTile(
            problem: 'La mauvaise version apparaît',
            solution:
                'Plusieurs JDK sont probablement installés. Dans VS Code, ouvre '
                'la palette de commandes et lance « Java: Configure Java Runtime ».',
          ),
          const _TroubleshootingTile(
            problem: 'Could not find or load main class Main',
            solution:
                'Place-toi dans le dossier qui contient Main.class et lance '
                'exactement « java Main », sans ajouter .class.',
          ),
          const _TroubleshootingTile(
            problem: 'class Main is public, should be declared…',
            solution:
                'Le nom du fichier doit respecter exactement la casse : Main.java.',
          ),
          const SizedBox(height: 20),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Plus tard seulement : JavaPath expliquera Git, Maven et Gradle '
                'avant de te demander de les utiliser. Ne les installe pas tous '
                'dès le premier jour.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.number, required this.title});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Text('$number')),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}

class _CopyAddressCard extends StatelessWidget {
  const _CopyAddressCard({required this.label, required this.address});

  final String label;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: const Icon(Icons.public_rounded),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(address),
        trailing: IconButton(
          tooltip: 'Copier l’adresse',
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: address));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adresse copiée')),
              );
            }
          },
          icon: const Icon(Icons.copy_rounded),
        ),
      ),
    );
  }
}

class _PlatformGuide extends StatelessWidget {
  const _PlatformGuide({
    required this.title,
    required this.icon,
    required this.steps,
  });

  final String title;
  final IconData icon;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        children: [
          for (var index = 0; index < steps.length; index++)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${index + 1}.',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(steps[index])),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _RequirementCard extends StatelessWidget {
  const _RequirementCard({
    required this.icon,
    required this.title,
    required this.items,
  });

  final IconData icon;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
      ),
    );
  }
}

class _TroubleshootingTile extends StatelessWidget {
  const _TroubleshootingTile({
    required this.problem,
    required this.solution,
  });

  final String problem;
  final String solution;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(Icons.build_circle_outlined),
        title: Text(problem),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        children: [Text(solution)],
      ),
    );
  }
}
