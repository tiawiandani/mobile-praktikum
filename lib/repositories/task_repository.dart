
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  final TaskService _taskService;

  TaskRepository({
    TaskService? taskService,
  }) : _taskService = taskService ?? TaskService();

  // Mengambil data dari REST API
  Future<List<Task>> getTasks() {
    return _taskService.fetchTasks();
  }

  // Mengambil data dari Supabase
  Future<List<Task>> getTasksFromSupabase() async {
    final data = await _supabase.from('tasks').select();

    return data.map((json) => Task.fromJson(json)).toList();
  }

  // Menambahkan tugas ke Supabase
 Future<void> addTaskToSupabase(Task task) async {
  await _supabase.from('tasks').insert({
    'id': task.id,
    'title': task.title,
    'course': task.course,
    'description': task.description,
    'due_date': task.dueDate.toIso8601String().split('T').first,
    'status': task.status,
  });
}

Future<void> updateTaskInSupabase(Task task) async {
  await _supabase.from('tasks').update({
    'title': task.title,
    'course': task.course,
    'description': task.description,
    'due_date': task.dueDate.toIso8601String().split('T').first,
    'status': task.status,
  }).eq('id', task.id);
}

Future<void> deleteTaskFromSupabase(String taskId) async {
  await _supabase.from('tasks').delete().eq('id', taskId);
}
}