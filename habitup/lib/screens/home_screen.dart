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
              child: ListView.builder(
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
                      title: Text(
                        habit.name,
                        style: const TextStyle(
                          color: Color(0xFF212529),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddHabitScreen(),
                    ),
                  );
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
