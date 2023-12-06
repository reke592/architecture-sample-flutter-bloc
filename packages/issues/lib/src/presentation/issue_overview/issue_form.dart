import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';

class IssueForm extends StatefulWidget {
  final String title;
  final String description;

  const IssueForm({
    super.key,
    this.title = '',
    this.description = '',
  });

  @override
  State<IssueForm> createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  late final TextEditingController title;
  late final TextEditingController description;

  @override
  void initState() {
    title = TextEditingController(text: widget.title);
    description = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          AppTheme.gap2,
          TextField(
            controller: description,
            decoration: const InputDecoration(
              label: Text('Description'),
            ),
            minLines: 5,
            maxLines: 10,
          ),
          AppTheme.gap2,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<IssueOverviewBloc>().add(
                        SubmitIssue(
                          title: title.text,
                          description: description.text,
                        ),
                      );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
