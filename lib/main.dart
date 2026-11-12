import 'models/student.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/task_provider.dart';
import 'screens/task_list_screen.dart';
import 'widgets/profile_card.dart';
import 'widgets/summary_card.dart';
import 'widgets/course_card.dart';

Future<Student> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  return Student.fromJson(
  jsonDecode(jsonString) as Map<String, dynamic>,
  );
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
  late Future<Student> studentFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text('Learning Dashboard'),
  actions: [
    IconButton(
      icon: const Icon(Icons.assignment),
      tooltip: 'Buka TaskMate',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskListScreen(),
          ),
        );
      },
    ),
  ],
),
      
      body: FutureBuilder<Student>(
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

          final nim = student.nim;
          final nama = student.nama;
          final courses = student.courses;

          // Menghitung total SKS
          final totalCredits = courses.fold<int>(
            0,
            (sum, course) => sum + course.credits,
          );
          final isWide = MediaQuery.sizeOf(context).width >= 600;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
               child: Padding(
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
                if (isWide)
  Row(
    children: [
      Expanded(
        child: SummaryCard(
          title: 'Total Mata Kuliah',
          value: '${courses.length}',
          icon: Icons.menu_book,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: SummaryCard(
          title: 'Total SKS',
          value: '$totalCredits',
          icon: Icons.school,
        ),
      ),
    ],
  )
else
  Column(
    children: [
      SizedBox(
        width: double.infinity,
        child: SummaryCard(
          title: 'Total Mata Kuliah',
          value: '${courses.length}',
          icon: Icons.menu_book,
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: SummaryCard(
          title: 'Total SKS',
          value: '$totalCredits',
          icon: Icons.school,
        ),
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
          child: isWide
        ? GridView.builder(
          itemCount: courses.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];

            return CourseCard(
              code: course.code,
              name: course.name,
              credits: course.credits,
              status: course.status,
              category: course.category,
            );
          },
        )
      : ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];

            return CourseCard(
              code: course.code,
              name: course.name,
              credits: course.credits,
              status: course.status,
              category: course.category,
            );
          },
        ),
      ),
                            ],
            ),
          ),
        ),); // Center
}, // builder
), // FutureBuilder
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskListScreen(),
              ),
            );
          } else {
            setState(() {
              _selectedIndex = 0;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment),
            label: 'TaskMate',
          ),
        ],
      ),
    );
  }
}

// ===============================
// MAIN APP
// ===============================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ruwxizjwvhhhaegtladw.supabase.co',
    publishableKey: 'sb_publishable_L_Jjq1F1J12RA5kJO3rgfQ_brpWhODk',
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
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

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
      ),
      body: const Center(
        child: Text('Halaman Detail Mata Kuliah'),
      ),
    );
  }
}