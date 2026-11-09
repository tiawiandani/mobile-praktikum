
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_detail_screen.dart';
import '../providers/task_provider.dart';
import 'task_add_screen.dart';
import 'rest_api_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions:[
          IconButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RestApiScreen(),
      ),
    );
  },
  icon: const Icon(Icons.cloud_download),
  tooltip: 'Data REST API',
),
          IconButton(
            onPressed: provider.isLoading
                ? null
                : () => provider.loadTasks(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: _buildBody(provider),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TaskAddScreen(),
    ),
  );
},
tooltip: 'Tambah Tugas',
child: const Icon(Icons.add),
),
    );
  }

  Widget _buildBody(TaskProvider provider) {
    if (provider.isLoading && provider.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.errorMessage != null &&
        provider.tasks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                provider.errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => provider.loadTasks(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.tasks.isEmpty) {
      return const Center(
        child: Text('Belum ada tugas.'),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.loadTasks,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          final task = provider.tasks[index];
          final isCompleted = task.status == 'Selesai';

          return Card(
            child: ListTile(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                    task: task,
                 ),
               ),
             );
          },
              leading: CircleAvatar(
                child: Icon(
                  isCompleted
                      ? Icons.check_circle
                      : Icons.assignment_outlined,
                ),
              ),
              title: Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${task.course}\n'
                'Tenggat: ${task.dueDate.day}/'
                '${task.dueDate.month}/'
                '${task.dueDate.year}',
              ),
              isThreeLine: true,
              trailing: Icon(
                isCompleted
                    ? Icons.check
                    : Icons.schedule,
                color: isCompleted
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
