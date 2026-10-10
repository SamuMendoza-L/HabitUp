import 'package:flutter/material.dart';

import 'add_habit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
