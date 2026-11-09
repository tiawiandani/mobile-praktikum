
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _courseController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _dueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _courseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
      });
    }
  }
Future<void> _saveTask() async { 
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tenggat waktu terlebih dahulu.'),
        ),
      );
      return;
    }

    final newTask = Task(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  title: _titleController.text.trim(),
  course: _courseController.text.trim(),
  description: _descriptionController.text.trim(),
  dueDate: _dueDate!,
  status: 'Belum selesai',
);

await context.read<TaskProvider>().addTask(newTask);
if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Tugas berhasil ditambahkan.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nama Tugas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tugas wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _courseController,
              decoration: const InputDecoration(
                labelText: 'Mata Kuliah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.menu_book),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Mata kuliah wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Tugas',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _dueDate == null
                    ? 'Pilih Tenggat Waktu'
                    : 'Tenggat: ${_dueDate!.day}/'
                        '${_dueDate!.month}/'
                        '${_dueDate!.year}',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveTask,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}
