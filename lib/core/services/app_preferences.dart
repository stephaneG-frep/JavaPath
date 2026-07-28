import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferences must be overridden'),
);

class AppSettings {
  const AppSettings({
    required this.onboardingComplete,
    required this.themeMode,
    this.learningLevel,
    this.learningGoal,
  });

  final bool onboardingComplete;
  final ThemeMode themeMode;
  final String? learningLevel;
  final String? learningGoal;

  AppSettings copyWith({
    bool? onboardingComplete,
    ThemeMode? themeMode,
    String? learningLevel,
    String? learningGoal,
  }) {
    return AppSettings(
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      themeMode: themeMode ?? this.themeMode,
      learningLevel: learningLevel ?? this.learningLevel,
      learningGoal: learningGoal ?? this.learningGoal,
    );
  }
}

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier(this._preferences)
      : super(
          AppSettings(
            onboardingComplete:
                _preferences.getBool('onboarding_complete') ?? false,
            themeMode: _readTheme(_preferences.getString('theme_mode')),
            learningLevel: _preferences.getString('learning_level'),
            learningGoal: _preferences.getString('learning_goal'),
          ),
        );

  final SharedPreferences _preferences;

  static ThemeMode _readTheme(String? value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> completeOnboarding({
    required String level,
    required String goal,
  }) async {
    await Future.wait([
      _preferences.setBool('onboarding_complete', true),
      _preferences.setString('learning_level', level),
      _preferences.setString('learning_goal', goal),
    ]);
    state = state.copyWith(
      onboardingComplete: true,
      learningLevel: level,
      learningGoal: goal,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _preferences.setString('theme_mode', mode.name);
    state = state.copyWith(themeMode: mode);
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier(ref.watch(sharedPreferencesProvider));
});
