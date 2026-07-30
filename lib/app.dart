import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/services/app_preferences.dart';
import 'core/theme/app_theme.dart';

class JavaPathApp extends ConsumerWidget {
  const JavaPathApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    return MaterialApp.router(
      title: 'JavaPath',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final systemScale = mediaQuery.textScaler.scale(1);
        final effectiveScale = (systemScale * settings.textScale)
            .clamp(0.8, 2.0)
            .toDouble();
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(effectiveScale),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
