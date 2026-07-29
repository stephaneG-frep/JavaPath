import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/code_block.dart';
import '../../courses/domain/activity_models.dart';
import '../../progress/data/progress_repository.dart';
import '../data/challenge_repository.dart';
import '../domain/answer_validator.dart';
import '../domain/hint_policy.dart';

class ChallengeScreen extends ConsumerStatefulWidget {
  const ChallengeScreen({required this.challengeId, super.key});

  final String challengeId;

  @override
  ConsumerState<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends ConsumerState<ChallengeScreen> {
  final _controller = TextEditingController();
  String? _choice;
  String? _feedback;
  int _hintsUsed = 0;
  int _attempts = 0;
  bool _partialSolutionVisible = false;
  bool _solutionViewed = false;
  bool _correct = false;
  bool _stateLoaded = false;

  String get _activityType =>
      widget.challengeId.startsWith('debug') ? 'debug' : 'prediction';

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_loadState);
  }

  Future<void> _loadState() async {
    final state = await ref
        .read(progressRepositoryProvider)
        .readActivityState(widget.challengeId, _activityType);
    if (!mounted) return;
    setState(() {
      _attempts = state.attempts;
      _hintsUsed = state.hintsUsed;
      _solutionViewed = state.solutionViewed;
      _stateLoaded = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _validate(Challenge challenge) async {
    final answer = challenge.choices.isEmpty ? _controller.text : _choice ?? '';
    if (answer.trim().isEmpty) return;
    await ref
        .read(progressRepositoryProvider)
        .recordAttempt(challenge.id, _activityType);
    _attempts++;
    final valid =
        AnswerValidator.matches(answer, challenge.acceptedAnswers);
    if (!valid) {
      await ref
          .read(progressRepositoryProvider)
          .recordReviewError(challenge.category);
      if (mounted) {
        setState(() {
          _feedback =
              'Ce n’est pas encore la bonne réponse. Analyse le code pas à pas ou utilise un indice.';
        });
      }
      return;
    }

    await ref.read(progressRepositoryProvider).recordCorrectAnswer();
    final reward = HintPolicy.reward(
      baseXp: challenge.xpReward,
      hintsUsed: _hintsUsed,
      solutionViewed: _solutionViewed,
    );
    final earned = await ref.read(progressRepositoryProvider).completeActivity(
          activityId: challenge.id,
          activityType: _activityType,
          xp: reward,
        );
    await ref
        .read(progressRepositoryProvider)
        .recordReviewSuccess(challenge.category);
    if (!mounted) return;
    setState(() {
      _correct = true;
      _feedback = earned
          ? reward > 0
              ? 'Bonne réponse ! +$reward XP'
              : 'Bonne réponse ! La solution ayant été affichée, aucun XP n’est attribué.'
          : 'Bonne réponse ! Ce challenge était déjà validé.';
    });
  }

  Future<void> _revealNextHint(Challenge challenge) async {
    final next = (_hintsUsed + 1).clamp(0, challenge.hints.length);
    await ref
        .read(progressRepositoryProvider)
        .revealHint(challenge.id, _activityType, next);
    if (mounted) setState(() => _hintsUsed = next);
  }

  Future<void> _revealSolution(Challenge challenge) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voir la solution complète ?'),
        content: const Text(
          'Tu pourras toujours répondre, mais cette activité ne rapportera plus d’XP.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Voir la solution'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref
        .read(progressRepositoryProvider)
        .viewSolution(challenge.id, _activityType);
    if (mounted) setState(() => _solutionViewed = true);
  }

  @override
  Widget build(BuildContext context) {
    final challenge = ref.watch(challengeProvider(widget.challengeId));
    if (challenge == null || !_stateLoaded) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final reward = HintPolicy.reward(
      baseXp: challenge.xpReward,
      hintsUsed: _hintsUsed,
      solutionViewed: _solutionViewed,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _activityType == 'debug' ? 'Debug Challenge' : 'Prédire le résultat',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text(challenge.category)),
              Chip(label: Text(challenge.difficulty)),
              Chip(
                avatar: const Icon(Icons.bolt_rounded, size: 18),
                label: Text('$reward XP'),
              ),
              if (_attempts > 0) Chip(label: Text('$_attempts tentative(s)')),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            challenge.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(challenge.prompt),
          const SizedBox(height: 18),
          CodeBlock(code: challenge.code),
          const SizedBox(height: 20),
          if (challenge.choices.isNotEmpty)
            for (final choice in challenge.choices)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: _choice == choice
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: ListTile(
                    onTap: _correct
                        ? null
                        : () => setState(() => _choice = choice),
                    leading: Icon(
                      _choice == choice
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                    ),
                    title: Text(choice),
                  ),
                ),
              )
          else
            TextField(
              controller: _controller,
              enabled: !_correct,
              minLines: 1,
              maxLines: 4,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Ta réponse',
                hintText: 'Écris exactement ce que le programme affiche',
              ),
            ),
          if (_feedback != null) ...[
            const SizedBox(height: 16),
            _FeedbackCard(
              correct: _correct,
              message: _feedback!,
              challenge: challenge,
            ),
          ],
          const SizedBox(height: 16),
          if (!_correct) ...[
            OutlinedButton.icon(
              onPressed: _hintsUsed < challenge.hints.length
                  ? () => _revealNextHint(challenge)
                  : null,
              icon: const Icon(Icons.lightbulb_outline_rounded),
              label: Text(
                _hintsUsed < challenge.hints.length
                    ? 'Afficher l’indice ${_hintsUsed + 1}'
                    : 'Tous les indices sont affichés',
              ),
            ),
            for (var index = 0; index < _hintsUsed; index++)
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(challenge.hints[index]),
                ),
              ),
            if (_hintsUsed == challenge.hints.length) ...[
              TextButton(
                onPressed: _partialSolutionVisible
                    ? null
                    : () => setState(() => _partialSolutionVisible = true),
                child: const Text('Afficher une partie de la solution'),
              ),
              if (_partialSolutionVisible)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(challenge.partialSolution),
                  ),
                ),
              if (_partialSolutionVisible && !_solutionViewed)
                TextButton(
                  onPressed: () => _revealSolution(challenge),
                  child: const Text('Voir la solution complète'),
                ),
            ],
            if (_solutionViewed)
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Solution',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(challenge.solution),
                      const SizedBox(height: 8),
                      Text(challenge.explanation),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: () => _validate(challenge),
                child: const Text('Valider ma réponse'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({
    required this.correct,
    required this.message,
    required this.challenge,
  });

  final bool correct;
  final String message;
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: correct
          ? Colors.green.withValues(alpha: 0.16)
          : Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: const TextStyle(fontWeight: FontWeight.w800)),
            if (correct) ...[
              const SizedBox(height: 10),
              Text(challenge.explanation),
              const SizedBox(height: 12),
              Text(
                challenge.detailTitle,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(challenge.detail),
            ],
          ],
        ),
      ),
    );
  }
}
