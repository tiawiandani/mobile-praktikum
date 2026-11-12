
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/models/student.dart';
import 'package:flutter_ui_fundamentals/models/task.dart';

void main() {
  group('Student Model Test', () {
    test('Berhasil membaca data mahasiswa dari JSON', () {
      final json = {
        'nim': '2415051103',
        'nama': 'Ni Made Tia Wiandani',
        'courses': [
          {
            'code': 'MOB01',
            'name': 'Git & GitHub',
            'credits': 2,
            'status': 'Selesai',
            'category': 'Version Control',
          },
        ],
      };

      final student = Student.fromJson(json);

      expect(student.nim, '2415051103');
      expect(student.nama, 'Ni Made Tia Wiandani');
      expect(student.courses.length, 1);
      expect(student.courses.first.name, 'Git & GitHub');
    });
  });

  group('Task Model Test', () {
    final taskJson = {
      'id': 1,
      'title': 'Belajar Flutter',
      'course': 'Pemrograman Mobile',
      'description': 'Mempelajari Model Dart',
      'due_date': '2026-11-20T10:00:00.000',
      'status': 'Belum selesai',
    };

    test('Berhasil membaca data Task dari JSON', () {
      final task = Task.fromJson(taskJson);

      expect(task.id, '1');
      expect(task.title, 'Belajar Flutter');
      expect(task.course, 'Pemrograman Mobile');
      expect(task.status, 'Belum selesai');
    });

    test('Berhasil mengubah Task menjadi JSON', () {
      final task = Task.fromJson(taskJson);
      final json = task.toJson();

      expect(json['title'], 'Belajar Flutter');
      expect(json['course'], 'Pemrograman Mobile');
      expect(json['status'], 'Belum selesai');
    });

    test('Berhasil memperbarui Task menggunakan copyWith', () {
      final task = Task.fromJson(taskJson);
      final updatedTask = task.copyWith(
        title: 'Belajar Supabase',
        status: 'Selesai',
      );

      expect(updatedTask.title, 'Belajar Supabase');
      expect(updatedTask.status, 'Selesai');
      expect(updatedTask.id, task.id);
    });
  });
}
