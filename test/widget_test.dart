
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/models/student.dart';

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
}
