import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';
import 'package:issues/src/presentation/issue_overview/issue_form.dart';

class IssueDetails extends StatelessWidget {
  const IssueDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueOverviewBloc, IssueOverviewState>(
      buildWhen: (_, current) => current.action is LoadOverview,
      builder: (context, state) {
        if (state.isLoading) return const LinearProgressIndicator();

        if (state.isSuccess && state.report.id == null) {
          return IssueForm(
            title: state.report.title,
            description: state.report.description,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.report.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              state.report.createdAt?.toIso8601String() ?? '',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            AppTheme.gap1,
            Text(
              'Description:',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(state.report.description),
            if (!state.isLoading) const Divider(),
          ],
        );
      },
    );
  }
}
