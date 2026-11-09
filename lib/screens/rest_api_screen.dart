
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class RestApiScreen extends StatefulWidget {
  const RestApiScreen({super.key});

  @override
  State<RestApiScreen> createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TaskProvider>().loadApiTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data REST API'),
        actions: [
          IconButton(
            onPressed: provider.isApiLoading
                ? null
                : () => provider.loadApiTasks(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(TaskProvider provider) {
    if (provider.isApiLoading && provider.apiTasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.apiErrorMessage != null &&
        provider.apiTasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(provider.apiErrorMessage!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => provider.loadApiTasks(),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (provider.apiTasks.isEmpty) {
      return const Center(
        child: Text('Belum ada data REST API.'),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.loadApiTasks,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: provider.apiTasks.length,
        itemBuilder: (context, index) {
          final task = provider.apiTasks[index];
          final isCompleted = task.status == 'Selesai';

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  isCompleted
                      ? Icons.check_circle
                      : Icons.assignment_outlined,
                ),
              ),
              title: Text(task.title),
              subtitle: Text(
                '${task.course}\n'
                'Status: ${task.status}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
