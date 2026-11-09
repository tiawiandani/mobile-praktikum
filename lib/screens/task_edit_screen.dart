
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;

  const TaskEditScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _courseController;
  late final TextEditingController _descriptionController;

  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.task.title);
    _courseController =
        TextEditingController(text: widget.task.course);
    _descriptionController =
        TextEditingController(text: widget.task.description);

    _dueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _courseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate.isBefore(now) ? now : _dueDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
      });
    }
  }
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedTask = widget.task.copyWith(
      title: _titleController.text.trim(),
      course: _courseController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _dueDate,
    );

    final taskProvider = context.read<TaskProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await taskProvider.updateTask(updatedTask);

      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Perubahan tugas berhasil disimpan.'),
        ),
      );

      navigator.pop();
    } catch (error) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan perubahan: $error'),
        ),
      );
    }
  }
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tugas'),
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
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                'Tenggat: ${_dueDate.day}/'
                '${_dueDate.month}/'
                '${_dueDate.year}',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
