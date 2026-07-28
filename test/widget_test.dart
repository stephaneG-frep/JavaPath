import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/app.dart';
import 'package:java_path/core/services/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('le premier lancement affiche l’onboarding', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
        ],
        child: const JavaPathApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Apprends Java pas à pas'), findsOneWidget);
    expect(find.text('Continuer'), findsOneWidget);
  });
}
