import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String task;
  final VoidCallback onDelete;

  TaskItem({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
