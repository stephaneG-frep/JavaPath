import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/help/presentation/help_screen.dart';

void main() {
  testWidgets('la page aide présente le démarrage rapide', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HelpScreen()),
    );

    expect(find.text('Mode d’emploi & aide'), findsOneWidget);
    expect(find.text('Démarrage rapide'), findsOneWidget);
    expect(find.text('Choisis une leçon'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Comprendre l’application'), findsOneWidget);
  });
}
