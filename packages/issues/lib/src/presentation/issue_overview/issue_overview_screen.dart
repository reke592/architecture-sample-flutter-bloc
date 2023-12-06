import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';
import 'package:issues/src/presentation/issue_overview/issue_comment_list_view.dart';
import 'package:issues/src/presentation/issue_overview/issue_details.dart';

class IssueOverviewScreen extends StatelessWidget {
  const IssueOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueOverviewBloc, IssueOverviewState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (state.action is SubmitIssue) {
            Navigator.maybePop(context);
            Future.microtask(
              () => context.pushNamed(
                'view Issue',
                pathParameters: {
                  'id': state.report.id.toString(),
                },
                extra: state.report,
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PreviousRouteLabel(),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IssueDetails(),
                IssueCommentListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
