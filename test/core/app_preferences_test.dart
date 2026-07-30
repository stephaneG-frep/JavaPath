import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/services/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('les préférences de profil et accessibilité sont persistées', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final notifier = AppSettingsNotifier(preferences);

    expect(notifier.state.displayName, 'Apprenant Java');
    expect(notifier.state.textScale, 1);
    expect(notifier.state.themeMode, ThemeMode.system);

    await notifier.setDisplayName('  Lina Code  ');
    await notifier.setLearningGoal('Créer des backends/API');
    await notifier.setTextScale(1.3);
    await notifier.setThemeMode(ThemeMode.dark);

    final restored = AppSettingsNotifier(preferences).state;
    expect(restored.displayName, 'Lina Code');
    expect(restored.learningGoal, 'Créer des backends/API');
    expect(restored.textScale, 1.3);
    expect(restored.themeMode, ThemeMode.dark);
  });

  test('la taille du texte reste dans les limites accessibles', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final notifier = AppSettingsNotifier(preferences);

    await notifier.setTextScale(4);
    expect(notifier.state.textScale, 1.3);

    await notifier.setTextScale(0.2);
    expect(notifier.state.textScale, 0.9);
  });
}
