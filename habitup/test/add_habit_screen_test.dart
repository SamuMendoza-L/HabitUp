import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitup/screens/add_habit_screen.dart';

void main() {
  testWidgets('permite ingresar el nombre de un hábito', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddHabitScreen()));

    expect(find.text('Nombre del hábito'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Beber agua');

    expect(find.text('Beber agua'), findsOneWidget);
  });
}
