part of 'issue_overview_bloc.dart';

@immutable
abstract class IssueOverviewEvent {}

abstract class IssueOverviewSequentialEvent extends IssueOverviewEvent {}

class LoadOverview extends IssueOverviewSequentialEvent {
  final int? id;
  LoadOverview(this.id);
}

class SubmitIssue extends IssueOverviewEvent {
  final String title;
  final String description;
  SubmitIssue({
    required this.title,
    required this.description,
  });
}
