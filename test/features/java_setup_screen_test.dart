import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/help/presentation/java_setup_screen.dart';

void main() {
  testWidgets('le guide explique les prérequis Java', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: JavaSetupScreen()),
    );

    expect(find.text('Installer Java'), findsOneWidget);
    expect(find.text('Ce qu’il faut installer'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('Installer le JDK 25 LTS'), findsOneWidget);
    expect(find.text('Téléchargement officiel Eclipse Temurin'), findsOneWidget);
  });
}
