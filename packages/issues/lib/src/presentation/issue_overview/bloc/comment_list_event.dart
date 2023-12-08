part of 'comment_list_bloc.dart';

@immutable
abstract class CommentListEvent {}

class LoadComments extends CommentListEvent {
  final int? issueReportId;
  LoadComments(this.issueReportId);
}

class AppendNewComment extends CommentListEvent {
  final IssueComment value;
  AppendNewComment(this.value);
}

class ReplaceExistingComment extends CommentListEvent {
  final IssueComment value;
  ReplaceExistingComment(this.value);
}
