import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/presentation/issue_overview/bloc/comment_list_bloc.dart';
import 'package:issues/src/presentation/issue_overview/bloc/issue_comment_bloc.dart';
import 'package:issues/src/presentation/issue_overview/bloc/issue_overview_bloc.dart';
import 'package:issues/src/presentation/issue_overview/listeners/listeners.dart';
import 'package:issues/src/presentation/issue_overview/widgets/widgets.dart';

class IssueOverviewScreen extends StatelessWidget {
  final int? id;
  const IssueOverviewScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IssueOverviewBloc(
            repo: context.read<IssuesRepository>(),
          )..add(LoadOverview(id)),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CommentListBloc(
            issueId: id,
            repo: context.read<IssuesRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => IssueCommentBloc(
            issueId: id,
            repo: context.read<IssuesRepository>(),
          ),
        ),
        BlocProvider(create: (context) => TextSelectionBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          onSubmitIssue,
          onAcceptSelectionData,
          onAcceptSelectionData,
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreviousRouteLabel(),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const IssueDetails(),
                  ),
                ),
                const Divider(
                  thickness: 0,
                  height: 0,
                  color: Colors.transparent,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
