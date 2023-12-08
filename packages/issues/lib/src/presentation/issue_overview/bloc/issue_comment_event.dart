part of 'issue_comment_bloc.dart';

@immutable
abstract class IssueCommentEvent {}

class QuoteMessage extends IssueCommentEvent {
  final IssueComment source;
  final String value;
  QuoteMessage({
    required this.source,
    required this.value,
  });
}

class RemoveQuotedMessage extends IssueCommentEvent {}

class SetCommentMessage extends IssueCommentEvent {
  final String value;
  SetCommentMessage(this.value);
}

class SubmitComment extends IssueCommentEvent {
  SubmitComment();
}

class ResetCommentForm extends IssueCommentEvent {}
