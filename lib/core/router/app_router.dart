import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/courses/presentation/learning_path_screen.dart';
import '../../features/courses/presentation/lesson_screen.dart';
import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/ai_mentor/presentation/ai_mentor_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/help/presentation/help_screen.dart';
import '../../features/help/presentation/java_setup_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/practice/presentation/exercise_list_screen.dart';
import '../../features/practice/presentation/exercise_screen.dart';
import '../../features/practice/presentation/challenge_list_screen.dart';
import '../../features/practice/presentation/challenge_screen.dart';
import '../../features/practice/presentation/practice_screen.dart';
import '../../features/practice/presentation/quiz_screen.dart';
import '../../features/playground/presentation/execution_history_screen.dart';
import '../../features/playground/presentation/playground_screen.dart';
import '../../features/playground/presentation/snippet_list_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/projects/presentation/project_list_screen.dart';
import '../../features/projects/presentation/project_screen.dart';
import '../../features/reviews/presentation/review_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../../features/shell/presentation/main_shell.dart';
import '../services/app_preferences.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final onboardingComplete =
      ref.watch(appSettingsProvider.select((value) => value.onboardingComplete));
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: onboardingComplete ? '/home' : '/onboarding',
    redirect: (context, state) {
      final onOnboarding = state.matchedLocation == '/onboarding';
      if (!onboardingComplete && !onOnboarding) return '/onboarding';
      if (onboardingComplete && onOnboarding) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learn',
                builder: (context, state) => const LearningPathScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/practice',
                builder: (context, state) => const PracticeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/projects',
                builder: (context, state) => const ProjectListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/lesson/:lessonId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => LessonScreen(
          lessonId: state.pathParameters['lessonId']!,
        ),
      ),
      GoRoute(
        path: '/quiz',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        path: '/exercises',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ExerciseListScreen(),
      ),
      GoRoute(
        path: '/exercise/:exerciseId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ExerciseScreen(
          exerciseId: state.pathParameters['exerciseId']!,
        ),
      ),
      GoRoute(
        path: '/challenges',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ChallengeListScreen(),
      ),
      GoRoute(
        path: '/challenge/:challengeId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ChallengeScreen(
          challengeId: state.pathParameters['challengeId']!,
        ),
      ),
      GoRoute(
        path: '/help',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const HelpScreen(),
      ),
      GoRoute(
        path: '/help/java-setup',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const JavaSetupScreen(),
      ),
      GoRoute(
        path: '/project/:projectId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ProjectScreen(
          projectId: state.pathParameters['projectId']!,
        ),
      ),
      GoRoute(
        path: '/playground',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => PlaygroundScreen(
          initialCode: state.extra as String?,
        ),
      ),
      GoRoute(
        path: '/playground/snippets',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SnippetListScreen(),
      ),
      GoRoute(
        path: '/playground/history',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ExecutionHistoryScreen(),
      ),
      GoRoute(
        path: '/statistics',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/achievements',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/reviews',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReviewScreen(),
      ),
      GoRoute(
        path: '/mentor',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AiMentorScreen(),
      ),
    ],
  );
});
