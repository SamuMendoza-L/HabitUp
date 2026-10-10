import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitup/screens/add_habit_screen.dart';

void main() {
  testWidgets('permite ingresar el nombre de un hábito', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddHabitScreen()));

    expect(find.text('Nombre del hábito'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Beber agua');

    expect(find.text('Beber agua'), findsOneWidget);
  });

  testWidgets('rechaza un nombre formado solo por espacios', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddHabitScreen()));

    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.pump();

    expect(find.text('Ingresa el nombre del hábito'), findsOneWidget);
  });

  testWidgets('muestra el botón para guardar y valida al presionarlo', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AddHabitScreen()));

    await tester.tap(find.text('Guardar hábito'));
    await tester.pump();

    expect(find.text('Ingresa el nombre del hábito'), findsOneWidget);
  });
}
