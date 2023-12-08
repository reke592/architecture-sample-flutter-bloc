part of 'issue_overview_bloc.dart';

typedef IssueOverviewState = BlocDataState<IssueReport, IssueOverviewEvent>;

@immutable
class IssueOverviewInitial extends IssueOverviewState {
  const IssueOverviewInitial({super.data = const IssueReport()});
}
