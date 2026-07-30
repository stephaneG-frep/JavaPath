import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../courses/domain/activity_models.dart';
import '../../progress/data/progress_repository.dart';
import '../data/practice_repository.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int _index = 0;
  int? _selected;
  bool _validated = false;
  bool _finished = false;
  int _correctAnswers = 0;

  Future<void> _validate(QuizQuestion question) async {
    if (_selected == null || _validated) return;
    final correct = _selected == question.correctChoiceIndex;
    final repository = ref.read(progressRepositoryProvider);
    await repository.recordAttempt(question.id, 'quiz');
    if (correct) {
      await repository.recordCorrectAnswer();
      await repository.completeActivity(
        activityId: question.id,
        activityType: 'quiz',
        xp: 5,
      );
      await repository.recordReviewSuccess(question.conceptId);
      _correctAnswers++;
    } else {
      await repository.recordReviewError(question.conceptId);
    }
    if (mounted) setState(() => _validated = true);
  }

  void _next(int total) {
    if (_index == total - 1) {
      setState(() => _finished = true);
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _validated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(practiceCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Java')),
      body: AsyncValueView(
        value: catalog,
        data: (value) {
          if (_finished) {
            return _QuizResult(
              correct: _correctAnswers,
              total: value.quizQuestions.length,
              onRestart: () => setState(() {
                _index = 0;
                _selected = null;
                _validated = false;
                _finished = false;
                _correctAnswers = 0;
              }),
            );
          }
          final question = value.quizQuestions[_index];
          return _QuestionView(
            question: question,
            position: _index + 1,
            total: value.quizQuestions.length,
            selected: _selected,
            validated: _validated,
            onSelected: (choice) {
              if (!_validated) setState(() => _selected = choice);
            },
            onValidate: () => _validate(question),
            onNext: () => _next(value.quizQuestions.length),
          );
        },
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    required this.question,
    required this.position,
    required this.total,
    required this.selected,
    required this.validated,
    required this.onSelected,
    required this.onValidate,
    required this.onNext,
  });
  final QuizQuestion question;
  final int position;
  final int total;
  final int? selected;
  final bool validated;
  final ValueChanged<int> onSelected;
  final VoidCallback onValidate;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isCorrect = selected == question.correctChoiceIndex;
    return SafeArea(
      child: Column(
        children: [
          LinearProgressIndicator(value: position / total),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Text('Question $position sur $total'),
                    const Spacer(),
                    const Chip(label: Text('+5 XP')),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  question.prompt,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                for (var index = 0; index < question.choices.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: _choiceColor(context, index),
                      child: ListTile(
                        onTap: validated ? null : () => onSelected(index),
                        leading: Icon(_choiceIcon(index)),
                        title: Text(question.choices[index]),
                      ),
                    ),
                  ),
                if (validated) ...[
                  const SizedBox(height: 12),
                  Card(
                    color: isCorrect
                        ? Colors.green.withValues(alpha: 0.16)
                        : Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isCorrect ? 'Bonne réponse !' : 'Pas tout à fait',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          Text(question.explanation),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: validated
                    ? onNext
                    : selected == null
                    ? null
                    : onValidate,
                child: Text(validated ? 'Question suivante' : 'Valider'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? _choiceColor(BuildContext context, int index) {
    if (!validated) {
      return selected == index
          ? Theme.of(context).colorScheme.primaryContainer
          : null;
    }
    if (index == question.correctChoiceIndex) {
      return Colors.green.withValues(alpha: 0.16);
    }
    if (index == selected) return Theme.of(context).colorScheme.errorContainer;
    return null;
  }

  IconData _choiceIcon(int index) {
    if (validated && index == question.correctChoiceIndex) {
      return Icons.check_circle_rounded;
    }
    if (validated && index == selected) return Icons.cancel_rounded;
    return selected == index
        ? Icons.radio_button_checked_rounded
        : Icons.radio_button_off_rounded;
  }
}

class _QuizResult extends StatelessWidget {
  const _QuizResult({
    required this.correct,
    required this.total,
    required this.onRestart,
  });
  final int correct;
  final int total;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events_rounded, size: 80),
            const SizedBox(height: 20),
            Text(
              'Quiz terminé',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text('$correct bonnes réponses sur $total'),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Recommencer'),
            ),
          ],
        ),
      ),
    );
  }
}
