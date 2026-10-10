import 'package:flutter/material.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Nuevo hábito'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.add_task_outlined,
                  color: Color(0xFF6B8E23),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Crea una rutina que quieras mantener cada día.',
                    style: TextStyle(
                      color: Color(0xFF6C757D),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Nombre del hábito',
              style: TextStyle(
                color: Color(0xFF212529),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Ej. Leer 20 minutos',
                hintStyle: const TextStyle(color: Color(0xFF6C757D)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFDEE2E6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFF6B8E23),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
