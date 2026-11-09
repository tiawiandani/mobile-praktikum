
import 'package:flutter/material.dart';

Future<bool> confirmDeleteTask(
  BuildContext context, {
  required String taskTitle,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Hapus Tugas?'),
        content: Text(
          'Apakah kamu yakin ingin menghapus tugas "$taskTitle"? '
          'Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
