
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

import '../widgets/task_delete_helper.dart';
import 'task_edit_screen.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == 'Selesai';

    return Scaffold(
  appBar: AppBar(
    title: const Text('Detail Tugas'),
    actions: [
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'Edit Tugas',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditScreen(task: task),
            ),
          );

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Hapus Tugas',
        onPressed: () async {
          final confirmed = await confirmDeleteTask(
            context,
            taskTitle: task.title,
          );

          if (!context.mounted || !confirmed) {
            return;
          }

          final taskProvider = context.read<TaskProvider>();
          final messenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

try {
  await taskProvider.removeTask(task.id);

 if (!context.mounted) return;
  messenger.showSnackBar(
    const SnackBar(
      content: Text('Tugas berhasil dihapus.'),
    ),
  );

  navigator.pop();
} catch (error) {
  if (!context.mounted) return;

  messenger.showSnackBar(
    SnackBar(
      content: Text('Gagal menghapus tugas: $error'),
    ),
  );
}

          
        },
      ),
    ],
  ),
  body: ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Icon(
        Icons.assignment,
        size: 72,
      ),
      const SizedBox(height: 20),
      Text(
        task.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Card(
        child: ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text('Mata Kuliah'),
          subtitle: Text(task.course),
        ),
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text('Tenggat Waktu'),
          subtitle: Text(
            '${task.dueDate.day}/'
            '${task.dueDate.month}/'
            '${task.dueDate.year}',
          ),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(
            isCompleted ? Icons.check_circle : Icons.schedule,
          ),
          title: const Text('Status'),
          subtitle: Text(task.status),
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Deskripsi',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        task.description.isEmpty
            ? 'Tidak ada deskripsi.'
            : task.description,
      ),
    ],
  ),
);
  }
}