part of 'issue_list_bloc.dart';

@immutable
class IssueListState {
  final BlocMutation mutation;
  final IssueListEvent? action;
  final List<IssueReport> data;
  final Object? error;

  const IssueListState({
    this.mutation = BlocMutation.initial,
    this.action,
    this.data = const [],
    this.error,
  });

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  IssueListState copyWith({
    required IssueListEvent action,
    required BlocMutation mutation,
    List<IssueReport>? data,
    Object? Function()? error,
  }) =>
      IssueListState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  IssueListState loading(IssueListEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );

  IssueListState success(IssueListEvent event, List<IssueReport> data) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  IssueListState failure(IssueListEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
      );
}
