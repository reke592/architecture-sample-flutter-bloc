import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/issue_report.dart';

part 'events.dart';

abstract class IssuesRepository {
  final domainEvent = PublishSubject<IssuesDomainEvent>();

  Stream<IssuesDomainEvent> getDomainEvent() =>
      domainEvent.stream.asBroadcastStream();

  // issue report
  Future<List<IssueReport>> getIssues();
  Future<IssueReport> loadOverview(int id);
  Future<IssueReport> createIssue(IssueReport value);
  Future<IssueReport> updateIssue(IssueReport value);

  // issue comments
  Future<List<IssueComment>> getComments(int issueReportId);
  Future<IssueComment> createComment(IssueComment value);
  Future<IssueComment> updateComment(IssueComment value);
}
