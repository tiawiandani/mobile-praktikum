
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String code;
  final String name;
  final int credits;
  final String status;
  final String category;

  const CourseCard({
    super.key,
    required this.code,
    required this.name,
    required this.credits,
    required this.status,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == 'Selesai';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            isCompleted ? Icons.check : Icons.schedule,
          ),
        ),
        title: Text(
          '$code - $name',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$credits SKS • $category'),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
        ),
      ),
    );
  }
}
