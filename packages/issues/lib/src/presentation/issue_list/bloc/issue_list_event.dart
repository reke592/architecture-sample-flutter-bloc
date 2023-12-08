part of 'issue_list_bloc.dart';

@immutable
abstract class IssueListEvent {}

class LoadIssues extends IssueListEvent {}

class AddNewItem extends IssueListEvent {
  final IssueReport value;
  AddNewItem(this.value);
}

class ReplaceExistingItem extends IssueListEvent {
  final IssueReport value;
  ReplaceExistingItem(this.value);
}
