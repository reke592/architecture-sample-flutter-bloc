import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';

class ButtonCreateTodo extends StatelessWidget {
  const ButtonCreateTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.pushNamed('new Todo');
      },
      icon: const Icon(Icons.add),
      label: const Text('Create Todo'),
    );
  }
}
