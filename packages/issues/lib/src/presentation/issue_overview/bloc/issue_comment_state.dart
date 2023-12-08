part of 'issue_comment_bloc.dart';

typedef IssueCommentState = BlocDataState<IssueComment, IssueCommentEvent>;

@immutable
class IssueCommentInitial extends IssueCommentState {
  const IssueCommentInitial({super.data = const IssueComment()});
}
