part of 'widgets.dart';

class IssueCommentListView extends StatelessWidget {
  const IssueCommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentListBloc, CommentListState>(
      buildWhen: (_, current) =>
          current.action is LoadComments ||
          current.action is AppendNewComment ||
          current.action is ReplaceExistingComment,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.isLoading) const LinearProgressIndicator(),
            for (var data in state.data) IssueCommentTile(data: data),
            const IssueCommentForm(),
          ],
        );
      },
    );
  }
}
