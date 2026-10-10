import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitup/screens/home_screen.dart';

void main() {
  testWidgets('actualiza el progreso al completar un hábito', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('0 de 4 hábitos'), findsOneWidget);

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.pump();

    expect(find.text('1 de 4 hábitos'), findsOneWidget);

    final progressIndicator = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(progressIndicator.value, 0.25);
  });
}
