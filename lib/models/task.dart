
class Task {
  final String id;
  final String title;
  final String course;
  final String description;
  final DateTime dueDate;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.course,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'] as String,
      course: json['course'] as String,
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['due_date'] as String),
      status: json['status'] as String? ?? 'Belum selesai',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'course': course,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'status': status,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? course,
    String? description,
    DateTime? dueDate,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      course: course ?? this.course,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }
}
