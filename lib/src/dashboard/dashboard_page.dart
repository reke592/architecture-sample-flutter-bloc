import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/issues.dart';
import 'package:login/login.dart';
import 'package:todos/todos.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [
          DropdownThemeOptions(),
          VerticalDivider(),
          LogoutButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TodosDashboardShortcut(),
            AppTheme.gap1,
            const IssuesDashboardShortcut(),
          ],
        ),
      ),
    );
  }
}
