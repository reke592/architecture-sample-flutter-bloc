part of 'issue_overview_bloc.dart';

@immutable
abstract class IssueOverviewEvent {}

class LoadComments extends IssueOverviewEvent {}

class SubmitIssue extends IssueOverviewEvent {}

class IssueSubmitted extends IssueOverviewEvent {
  final IssueReport value;
  final bool isNewRecord;
  IssueSubmitted({
    required this.value,
    required this.isNewRecord,
  });
}
