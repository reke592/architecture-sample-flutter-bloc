import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/bloc/issue_comment_bloc.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/issue_report.dart';

abstract class IssueRepository {
  /// - inform list bloc about recently created/updated issues
  final issueOverviewEvent = PublishSubject<IssueOverviewEvent>();

  /// - inform overview bloc about recently created/updated comments
  final issueCommentEvent = PublishSubject<IssueCommentEvent>();

  Stream<IssueOverviewEvent> getIssueOverviewEvent() =>
      issueOverviewEvent.stream.asBroadcastStream();

  Stream<IssueCommentEvent> getIssueCommentEvent() =>
      issueCommentEvent.stream.asBroadcastStream();

  // issue report
  Future<List<IssueReport>> getIssues();
  Future<IssueReport> createIssue(IssueReport value);
  Future<IssueReport> updateIssue(IssueReport value);

  // issue comments
  Future<List<IssueComment>> getComments(IssueReport value);
  Future<IssueComment> createComment(IssueComment value);
  Future<IssueComment> updateComment(IssueComment value);
}
