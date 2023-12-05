part of 'issue_comment_bloc.dart';

@immutable
abstract class IssueCommentEvent {}

class ChangeMessage extends IssueCommentEvent {
  final String value;
  ChangeMessage(this.value);
}

class SubmitComment extends IssueCommentEvent {}

class CommentSubmitted extends IssueCommentEvent {
  final IssueComment value;
  final bool isNewRecord;
  CommentSubmitted({
    required this.value,
    required this.isNewRecord,
  });
}
