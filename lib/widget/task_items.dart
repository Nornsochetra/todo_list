import 'package:flutter/material.dart';
import '../models/tasks.dart';

class TaskItems extends StatelessWidget {
  final Tasks task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  TaskItems({
    required this.task,
    required this.onToggle,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: task.isDone, // never null now
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title ?? "No tasks",
          style: TextStyle(
            decoration:
            task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}