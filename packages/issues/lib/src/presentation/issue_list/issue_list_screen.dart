import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/presentation/issue_list/widgets/widgets.dart';

class IssueListScreen extends StatelessWidget {
  const IssueListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issues'),
        leading: BackButton(onPressed: () {
          context.goNamed('dashboard');
        }),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              children: [
                ButtonNewIssue(),
              ],
            ),
            Divider(),
            IssueListView(),
          ],
        ),
      ),
    );
  }
}
