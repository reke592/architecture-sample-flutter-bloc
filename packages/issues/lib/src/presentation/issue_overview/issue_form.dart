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
  bool loading = false;

  @override
  void initState() {
    title = TextEditingController(text: widget.title);
    description = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueOverviewBloc, IssueOverviewState>(
      listener: (context, state) {
        if (state.action is SubmitIssue) {
          setState(() {
            loading = state.isLoading;
          });
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report new Issue',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              AppTheme.gap2,
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
                    onPressed: loading
                        ? null
                        : () {
                            context.read<IssueOverviewBloc>().add(
                                  SubmitIssue(
                                    title: title.text,
                                    description: description.text,
                                  ),
                                );
                          },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
