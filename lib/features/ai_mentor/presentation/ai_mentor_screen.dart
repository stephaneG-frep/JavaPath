import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local_guided_mentor_service.dart';
import '../domain/ai_mentor_service.dart';

class AiMentorScreen extends ConsumerStatefulWidget {
  const AiMentorScreen({super.key});

  @override
  ConsumerState<AiMentorScreen> createState() => _AiMentorScreenState();
}

class _AiMentorScreenState extends ConsumerState<AiMentorScreen> {
  final _controller = TextEditingController();
  final _messages = <MentorMessage>[];
  bool _waiting = false;

  static const _suggestions = [
    'Explique-moi les variables',
    'Pourquoi utilise-t-on private ?',
    'Comment fonctionne une boucle for ?',
    'Qu’est-ce que null ?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send([String? suggestion]) async {
    final text = (suggestion ?? _controller.text).trim();
    if (text.isEmpty || _waiting) return;
    _controller.clear();
    setState(() {
      _messages.add(
        MentorMessage(
          author: MentorAuthor.user,
          text: text,
          createdAt: DateTime.now(),
        ),
      );
      _waiting = true;
    });
    final response = await ref
        .read(aiMentorServiceProvider)
        .respond(
          MentorRequest(message: text, type: MentorRequestType.explainConcept),
        );
    if (!mounted) return;
    setState(() {
      _messages.add(response);
      _waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Java Mentor')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            padding: const EdgeInsets.all(14),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.offline_bolt_rounded),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Guide local — l’intelligence artificielle n’est pas '
                    'connectée. Tes messages restent sur cet écran.',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _messages.isEmpty
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Icon(Icons.psychology_alt_rounded, size: 72),
                      const SizedBox(height: 14),
                      Text(
                        'Que veux-tu comprendre ?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 20),
                      for (final suggestion in _suggestions)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: OutlinedButton(
                            onPressed: () => _send(suggestion),
                            child: Text(suggestion),
                          ),
                        ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) =>
                        _MessageBubble(message: _messages[index]),
                  ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                    decoration: const InputDecoration(
                      hintText: 'Pose une question sur Java…',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Envoyer',
                  onPressed: _waiting ? null : _send,
                  icon: _waiting
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final MentorMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.author == MentorAuthor.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isLocalGuide) ...[
              const Text(
                'GUIDE LOCAL',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
            ],
            SelectableText(message.text),
          ],
        ),
      ),
    );
  }
}
