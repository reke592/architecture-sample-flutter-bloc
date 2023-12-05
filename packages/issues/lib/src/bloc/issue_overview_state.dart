part of 'issue_overview_bloc.dart';

@immutable
class IssueOverviewState {
  final IssueOverviewEvent? action;
  final BlocMutation mutation;
  final IssueReport data;

  const IssueOverviewState({
    this.action,
    this.mutation = BlocMutation.initial,
    this.data = const IssueReport(),
  });

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  IssueOverviewState copyWith({
    required IssueOverviewEvent action,
    required BlocMutation mutation,
    IssueReport? data,
    List<IssueComment>? comments,
  }) =>
      IssueOverviewState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
      );

  IssueOverviewState loading(IssueOverviewEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );

  IssueOverviewState success(IssueOverviewEvent event, IssueReport data) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  IssueOverviewState failure(IssueOverviewEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
      );

  IssueOverviewState withComments(
    IssueOverviewEvent event,
    List<IssueComment> comments,
  ) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data.copyWith(comments: comments),
      );
}
