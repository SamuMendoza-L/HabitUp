import 'package:flutter/material.dart';

import 'add_habit_screen.dart';
import '../models/habit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> habits = [
    Habit(name: 'Leer 20 minutos'),
    Habit(name: 'Meditar 10 minutos'),
    Habit(name: 'Caminar 30 minutos'),
    Habit(name: 'Planear mi día'),
  ];

  int get completedHabitsCount =>
      habits.where((habit) => habit.isCompleted).length;

  double get progress =>
      habits.isEmpty ? 0 : completedHabitsCount / habits.length;

  Future<void> _editHabit(int index) async {
    final habit = habits[index];
    final habitName = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AddHabitScreen(initialName: habit.name),
      ),
    );

    if (habitName == null) {
      return;
    }

    setState(() {
      habits[index] = Habit(
        name: habitName,
        isCompleted: habit.isCompleted,
      );
    });
  }

  Future<void> _deleteHabit(int index) async {
    final habit = habits[index];
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar hábito?'),
        content: Text('Se eliminará "${habit.name}" de tu lista.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFB00020),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      setState(() {
        habits.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        foregroundColor: const Color(0xFF212529),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('HabitUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Buenos días!',
                        style: TextStyle(
                          color: Color(0xFF6C757D),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Mis hábitos',
                        style: TextStyle(
                          color: Color(0xFF212529),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF6C757D),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              color: const Color(0xFFB9FF2C),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu progreso de hoy',
                      style: TextStyle(
                        color: Color(0xFF212529),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completedHabitsCount de ${habits.length} hábitos',
                      style: const TextStyle(
                        color: Color(0xFF212529),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        color: const Color(0xFF212529),
                        backgroundColor: const Color(0x80FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Hábitos de hoy',
              style: TextStyle(
                color: Color(0xFF212529),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: habits.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.checklist_outlined,
                            color: Color(0xFF6B8E23),
                            size: 48,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Empieza creando tu primer hábito',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF212529),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Registra una rutina y avanza paso a paso.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6C757D),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        final habit = habits[index];

                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Color(0xFFDEE2E6)),
                          ),
                          child: CheckboxListTile(
                            value: habit.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                habit.isCompleted = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFFB9FF2C),
                            checkColor: const Color(0xFF212529),
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    habit.name,
                                    style: const TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Editar ${habit.name}',
                                  icon: const Icon(Icons.edit_outlined),
                                  iconSize: 18,
                                  color: const Color(0xFF6C757D),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () => _editHabit(index),
                                ),
                                IconButton(
                                  tooltip: 'Eliminar ${habit.name}',
                                  icon: const Icon(Icons.delete_outline),
                                  iconSize: 18,
                                  color: const Color(0xFF6C757D),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () => _deleteHabit(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final habitName = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddHabitScreen(),
                    ),
                  );

                  if (habitName == null) {
                    return;
                  }

                  setState(() {
                    habits.add(Habit(name: habitName));
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar hábito'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB9FF2C),
                  foregroundColor: const Color(0xFF212529),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
