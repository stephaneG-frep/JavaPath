import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../courses/domain/activity_models.dart';
import '../data/challenge_repository.dart';

class ChallengeListScreen extends ConsumerWidget {
  const ChallengeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(challengeCatalogProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Challenges'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.bug_report_rounded), text: 'Débogage'),
              Tab(icon: Icon(Icons.visibility_rounded), text: 'Prédiction'),
            ],
          ),
        ),
        body: AsyncValueView(
          value: catalog,
          data: (value) => TabBarView(
            children: [
              _ChallengeList(
                challenges: value.debugChallenges,
                emptyMessage: 'Aucun challenge de débogage.',
              ),
              _ChallengeList(
                challenges: value.predictions,
                emptyMessage: 'Aucune prédiction.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengeList extends StatelessWidget {
  const _ChallengeList({
    required this.challenges,
    required this.emptyMessage,
  });

  final List<Challenge> challenges;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) return Center(child: Text(emptyMessage));
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: challenges.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            onTap: () => context.push('/challenge/${challenge.id}'),
            leading: CircleAvatar(
              child: Icon(
                challenge.id.startsWith('debug')
                    ? Icons.bug_report_rounded
                    : Icons.visibility_rounded,
              ),
            ),
            title: Text(
              challenge.title,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              '${challenge.category} • ${challenge.difficulty} • '
              '+${challenge.xpReward} XP',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        );
      },
    );
  }
}
