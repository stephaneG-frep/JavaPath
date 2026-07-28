import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/app_preferences.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  String? _level;
  String? _goal;

  static const _slides = [
    (
      icon: Icons.route_rounded,
      title: 'Apprends Java pas à pas',
      text: 'Un parcours progressif qui explique toujours le pourquoi.',
    ),
    (
      icon: Icons.code_rounded,
      title: 'Écris du code et relève des défis',
      text: 'Passe rapidement de la théorie à la pratique.',
    ),
    (
      icon: Icons.emoji_events_rounded,
      title: 'Gagne de l’XP et suis ta progression',
      text: 'Avance à ton rythme et célèbre chaque étape.',
    ),
  ];

  static const _levels = [
    'Je débute totalement',
    'J’ai quelques bases',
    'Niveau intermédiaire',
    'Je connais déjà Java',
  ];

  static const _goals = [
    'Découvrir la programmation',
    'Apprendre Java',
    'Préparer une formation',
    'Trouver un emploi',
    'Développer des applications',
    'Créer des backends/API',
    'Me perfectionner',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (_page < 4) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
      return;
    }
    if (_level == null || _goal == null) return;
    await ref
        .read(appSettingsProvider.notifier)
        .completeOnboarding(level: _level!, goal: _goal!);
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final canContinue =
        _page < 3 || (_page == 3 && _level != null) || (_page == 4 && _goal != null);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Text(
                    'JavaPath',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Text('${_page + 1}/5'),
                ],
              ),
            ),
            LinearProgressIndicator(value: (_page + 1) / 5),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => setState(() => _page = value),
                children: [
                  for (final slide in _slides)
                    _IntroSlide(
                      icon: slide.icon,
                      title: slide.title,
                      text: slide.text,
                    ),
                  _ChoicePage(
                    title: 'Quel est ton niveau ?',
                    subtitle: 'Nous adapterons bientôt les recommandations.',
                    values: _levels,
                    selected: _level,
                    onSelected: (value) => setState(() => _level = value),
                  ),
                  _ChoicePage(
                    title: 'Quel est ton objectif ?',
                    subtitle: 'Tu pourras le modifier depuis ton profil.',
                    values: _goals,
                    selected: _goal,
                    onSelected: (value) => setState(() => _goal = value),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: canContinue ? _continue : null,
                  child: Text(_page == 4 ? 'Commencer mon parcours' : 'Continuer'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroSlide extends StatelessWidget {
  const _IntroSlide({
    required this.icon,
    required this.title,
    required this.text,
  });
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 84),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _ChoicePage extends StatelessWidget {
  const _ChoicePage({
    required this.title,
    required this.subtitle,
    required this.values,
    required this.selected,
    required this.onSelected,
  });
  final String title;
  final String subtitle;
  final List<String> values;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(subtitle),
        const SizedBox(height: 24),
        for (final value in values)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () => onSelected(value),
                selected: selected == value,
                leading: Icon(
                  selected == value
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected == value
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
