import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../courses/domain/activity_models.dart';
import '../../progress/data/progress_repository.dart';
import '../data/practice_repository.dart';
import '../domain/answer_validator.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  const ExerciseScreen({required this.exerciseId, super.key});
  final String exerciseId;

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  final _controller = TextEditingController();
  String? _choice;
  bool _correct = false;
  String? _feedback;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _validate(Exercise exercise) async {
    final answer = exercise.choices.isEmpty ? _controller.text : _choice ?? '';
    final valid = AnswerValidator.matches(answer, exercise.acceptedAnswers);
    if (!valid) {
      setState(() {
        _feedback =
            'Ce n’est pas encore ça. Relis la consigne et essaie une autre réponse.';
      });
      return;
    }

    final earned = await ref.read(progressRepositoryProvider).completeActivity(
          activityId: exercise.id,
          activityType: 'exercise',
          xp: exercise.xpReward,
        );
    if (!mounted) return;
    setState(() {
      _correct = true;
      _feedback = earned
          ? 'Bonne réponse ! +${exercise.xpReward} XP'
          : 'Bonne réponse ! Cet exercice était déjà validé.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = ref.watch(exerciseProvider(widget.exerciseId));
    if (exercise == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Exercice')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text(exercise.difficulty)),
              Chip(label: Text('+${exercise.xpReward} XP')),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            exercise.prompt,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 24),
          if (exercise.choices.isNotEmpty)
            for (final choice in exercise.choices)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: _choice == choice
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: ListTile(
                    onTap: _correct ? null : () => setState(() => _choice = choice),
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
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Ta réponse',
                hintText: 'Écris uniquement la partie demandée',
              ),
              minLines: 1,
              maxLines: 4,
            ),
          if (_feedback != null) ...[
            const SizedBox(height: 20),
            Card(
              color: _correct
                  ? Colors.green.withValues(alpha: 0.16)
                  : Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _feedback!,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    if (_correct) ...[
                      const SizedBox(height: 8),
                      Text(exercise.explanation),
                    ],
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _correct ? null : () => _validate(exercise),
              child: const Text('Valider ma réponse'),
            ),
          ),
        ],
      ),
    );
  }
}
