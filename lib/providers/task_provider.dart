
import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;

  TaskProvider({
    TaskRepository? repository,
  }) : _repository = repository ?? TaskRepository();

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => List.unmodifiable(_tasks);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Task> _apiTasks = [];
bool _isApiLoading = false;
String? _apiErrorMessage;

List<Task> get apiTasks => List.unmodifiable(_apiTasks);
bool get isApiLoading => _isApiLoading;
String? get apiErrorMessage => _apiErrorMessage;

Future<void> loadApiTasks() async {
  _isApiLoading = true;
  _apiErrorMessage = null;
  notifyListeners();

  try {
    _apiTasks = await _repository.getTasks();
  } catch (error) {
    _apiErrorMessage = 'Gagal memuat data REST API: $error';
  } finally {
    _isApiLoading = false;
    notifyListeners();
  }
}

  Future<void> loadTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tasks = await _repository.getTasksFromSupabase();
    } catch (error) {
      _errorMessage = 'Gagal memuat tugas: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
   Future<void> addTask(Task task) async {
  await _repository.addTaskToSupabase(task);
  _tasks.insert(0, task);
  notifyListeners();
}

    Future<void> updateTask(Task updatedTask) async {
  await _repository.updateTaskInSupabase(updatedTask);

  final index = _tasks.indexWhere(
    (task) => task.id == updatedTask.id,
  );

  if (index != -1) {
    _tasks[index] = updatedTask;
    notifyListeners();
  }
}

 Future<void> removeTask(String taskId) async {
  await _repository.deleteTaskFromSupabase(taskId);

  _tasks.removeWhere(
    (task) => task.id == taskId,
  );

  notifyListeners();
}
}