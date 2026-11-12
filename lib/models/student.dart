
class Student {
  final String nim;
  final String nama;
  final List<Course> courses;

  const Student({
    required this.nim,
    required this.nama,
    required this.courses,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      nim: json['nim'] as String,
      nama: json['nama'] as String,
      courses: (json['courses'] as List<dynamic>)
          .map((course) => Course.fromJson(
                course as Map<String, dynamic>,
              ))
          .toList(),
    );
  }
}

class Course {
  final String code;
  final String name;
  final int credits;
  final String status;
  final String category;

  const Course({
    required this.code,
    required this.name,
    required this.credits,
    required this.status,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String,
      name: json['name'] as String,
      credits: json['credits'] as int,
      status: json['status'] as String,
      category: json['category'] as String,
    );
  }
}
