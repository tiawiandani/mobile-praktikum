
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task.dart';

class TaskService {
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/todos';

  Future<List<Task>> fetchTasks() async {
    final response = await http
        .get(Uri.parse(_baseUrl))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil data tugas: ${response.statusCode}',
      );
    }

    final List<dynamic> jsonList =
        jsonDecode(response.body) as List<dynamic>;

    return jsonList.map((item) {
      final json = item as Map<String, dynamic>;

      return Task(
        id: json['id'].toString(),
        title: json['title'] as String,
        course: 'Mata Kuliah Umum',
        description: 'Data contoh dari REST API',
        dueDate: DateTime.now().add(
          Duration(days: (json['id'] as int) % 7),
        ),
        status: json['completed'] == true
            ? 'Selesai'
            : 'Belum selesai',
      );
    }).toList();
  }
}
