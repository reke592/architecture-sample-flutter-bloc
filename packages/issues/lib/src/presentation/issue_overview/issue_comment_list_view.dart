import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';
import 'package:issues/src/presentation/issue_overview/issue_comment_tile.dart';

class IssueCommentListView extends StatelessWidget {
  const IssueCommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueOverviewBloc, IssueOverviewState>(
      buildWhen: (_, current) => current.action is LoadComments,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.isLoading) const LinearProgressIndicator(),
            for (var data in state.comments) IssueCommentTile(data: data)
          ],
        );
      },
    );
  }
}
