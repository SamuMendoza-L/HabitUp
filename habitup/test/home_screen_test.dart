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

  testWidgets('agrega un hábito al regresar desde la pantalla de creación', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.text('Agregar hábito'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'Beber agua');
    await tester.tap(find.text('Guardar hábito'));
    await tester.pumpAndSettle();

    expect(find.text('0 de 5 hábitos'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Beber agua'),
      100,
      scrollable: find.byType(Scrollable),
    );

    expect(find.text('Beber agua'), findsOneWidget);
  });

  testWidgets('permite completar un hábito nuevo y recalcula el progreso', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.pump();
    expect(find.text('1 de 4 hábitos'), findsOneWidget);

    await tester.tap(find.text('Agregar hábito'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Beber agua');
    await tester.tap(find.text('Guardar hábito'));
    await tester.pumpAndSettle();

    expect(find.text('1 de 5 hábitos'), findsOneWidget);
    expect(
      tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      ).value,
      0.2,
    );

    await tester.scrollUntilVisible(
      find.text('Beber agua'),
      100,
      scrollable: find.byType(Scrollable),
    );
    final newHabitTile = find.ancestor(
      of: find.text('Beber agua'),
      matching: find.byType(CheckboxListTile),
    );

    await tester.tap(newHabitTile);
    await tester.pump();
    expect(find.text('2 de 5 hábitos'), findsOneWidget);

    await tester.tap(newHabitTile);
    await tester.pump();
    expect(find.text('1 de 5 hábitos'), findsOneWidget);
  });

  testWidgets('edita un hábito y conserva su estado de cumplimiento', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.pump();
    await tester.tap(find.byTooltip('Editar Leer 20 minutos'));
    await tester.pumpAndSettle();

    expect(find.text('Editar hábito'), findsOneWidget);
    expect(
      tester.widget<TextFormField>(find.byType(TextFormField)).controller!.text,
      'Leer 20 minutos',
    );

    await tester.enterText(find.byType(TextFormField), 'Leer 30 minutos');
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    expect(find.text('Leer 30 minutos'), findsOneWidget);
    expect(find.text('1 de 4 hábitos'), findsOneWidget);
  });

  testWidgets('elimina un hábito después de confirmar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.byTooltip('Eliminar Leer 20 minutos'));
    await tester.pumpAndSettle();

    expect(find.text('¿Eliminar hábito?'), findsOneWidget);
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.text('Leer 20 minutos'), findsNothing);
    expect(find.text('0 de 3 hábitos'), findsOneWidget);
  });
}
