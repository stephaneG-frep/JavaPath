import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/features/courses/domain/activity_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('le catalogue contient trois projets guidés complets', () async {
    final source =
        await rootBundle.loadString('assets/content/projects_fr.json');
    final json = jsonDecode(source) as Map<String, dynamic>;
    final projects = (json['projects'] as List<dynamic>)
        .map((item) => LearningProject.fromJson(item as Map<String, dynamic>))
        .toList();

    expect(projects, hasLength(3));
    expect(
      projects.expand((project) => project.missions),
      hasLength(17),
    );
    expect(
      projects.every(
        (project) =>
            project.xpReward == 200 &&
            project.missions.every(
              (mission) =>
                  mission.successCriteria.isNotEmpty &&
                  mission.starterCode.isNotEmpty,
            ),
      ),
      isTrue,
    );
  });
}
