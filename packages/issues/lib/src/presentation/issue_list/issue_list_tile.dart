import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/domain/models/issue_report.dart';

class IssueListTile extends StatelessWidget {
  final IssueReport data;

  const IssueListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title),
      trailing: Text(data.createdAt!.toIso8601String()),
      onTap: () {
        context.pushNamed('view Issue', pathParameters: {
          'id': data.id.toString(),
        });
      },
    );
  }
}
