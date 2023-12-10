import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';

class IssuesDashboardShortcut extends StatelessWidget {
  const IssuesDashboardShortcut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.goNamed('Issue List');
      },
      icon: const Icon(Icons.play_arrow),
      label: const Text('Issues'),
    );
  }
}
