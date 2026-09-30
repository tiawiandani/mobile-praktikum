import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// ===============================
// REUSABLE WIDGET: PROFILE CARD
// ===============================
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              child: Icon(
                Icons.person,
                size: 36,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIM: $nim',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// REUSABLE WIDGET: SUMMARY CARD
// ===============================
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===============================
// DASHBOARD PAGE
// ===============================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard '),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // ===============================
          // LOADING STATE
          // ===============================
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ===============================
          // ERROR STATE
          // ===============================
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi error: ${snapshot.error}',
              ),
            );
          }

          // ===============================
          // DATA TIDAK TERSEDIA
          // ===============================
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          final student = snapshot.data!;

          final nim = student['nim'] as String;
          final nama = student['nama'] as String;

          final courses =
              student['courses'] as List<dynamic>;

          // Menghitung total SKS
          final totalCredits = courses.fold<int>(
            0,
            (sum, course) =>
                sum + (course['credits'] as int),
          );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===============================
                // PROFILE / IDENTITY
                // ===============================
                ProfileCard(
                  nama: nama,
                  nim: nim,
                ),

                const SizedBox(height: 12),

                // ===============================
                // SUMMARY CARDS
                // ===============================
                Row(
                  children: [
                    SummaryCard(
                      title: 'Total Mata Kuliah',
                      value: '${courses.length}',
                      icon: Icons.menu_book,
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      title: 'Total SKS',
                      value: '$totalCredits',
                      icon: Icons.school,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ===============================
                // COURSE LIST TITLE
                // ===============================
                const Text(
                  'Daftar Mata Kuliah',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // ===============================
                // COURSE LIST
                // ===============================
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      final code =
                          course['code'] as String;
                      final name =
                          course['name'] as String;
                      final credits =
                          course['credits'] as int;
                      final status =
                          course['status'] as String;
                      final category =
                          course['category'] as String;

                      final isCompleted =
                          status == 'Selesai';

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              isCompleted
                                  ? Icons.check
                                  : Icons.schedule,
                            ),
                          ),
                          title: Text(
                            '$code - $name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '$credits SKS • $category',
                          ),
                          trailing: Text(
                            status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCompleted
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ===============================
// MAIN APP
// ===============================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}