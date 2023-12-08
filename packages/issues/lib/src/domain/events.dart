part of 'issues_repository.dart';

/// The bloc communicates with other blocs through the repository domain event stream.
///
/// another way is to use a [BlocListener] but this approach requires a Widget context.
abstract class IssuesDomainEvent extends Equatable {}

/// reported by [IssueOverviewBloc] aflter successful loading record from data source.
class IssueReportLoaded extends IssuesDomainEvent {
  final IssueReport value;
  IssueReportLoaded(this.value);
  @override
  List<Object?> get props => [value];
}

/// reported by [IssueOverviewBloc] after successful submit of new report.
class IssueReportSubmitted extends IssuesDomainEvent {
  final IssueReport value;
  final bool isNewRecord;
  IssueReportSubmitted({
    required this.value,
    required this.isNewRecord,
  });
  @override
  List<Object?> get props => [value, isNewRecord];
}

/// reported by [IssueCommentBloc] after successful submit of new comment.
class CommentSubmitted extends IssuesDomainEvent {
  final IssueComment value;
  final bool isNewRecord;
  CommentSubmitted({
    required this.value,
    required this.isNewRecord,
  });
  @override
  List<Object?> get props => [value, isNewRecord];
}
