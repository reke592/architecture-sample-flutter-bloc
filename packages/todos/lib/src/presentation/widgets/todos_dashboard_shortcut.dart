import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';

class TodosDashboardShortcut extends StatelessWidget {
  const TodosDashboardShortcut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.goNamed('Todo List');
      },
      icon: const Icon(Icons.play_arrow),
      label: const Text('Todo List'),
    );
  }
}
