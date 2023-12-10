part of 'issue_list_bloc.dart';

typedef IssueListState = BlocDataState<List<IssueReport>, IssueListEvent>;

@immutable
class IssueListInitial extends IssueListState {
  const IssueListInitial({super.data = const []});
}
