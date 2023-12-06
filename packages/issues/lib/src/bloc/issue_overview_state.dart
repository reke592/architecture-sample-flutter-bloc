part of 'issue_overview_bloc.dart';

@immutable
class IssueOverviewState extends Equatable {
  final IssueOverviewEvent? action;
  final BlocMutation mutation;
  final IssueReport report;
  final List<IssueComment> comments;
  final Object? error;

  const IssueOverviewState({
    this.action,
    this.mutation = BlocMutation.initial,
    this.report = const IssueReport(),
    this.comments = const [],
    this.error,
  });

  @override
  List<Object?> get props => [
        report,
        comments,
        error,
        action,
        mutation,
      ];

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  IssueOverviewState copyWith({
    required IssueOverviewEvent action,
    required BlocMutation mutation,
    IssueReport? report,
    List<IssueComment>? comments,
    Object? Function()? error,
  }) =>
      IssueOverviewState(
        action: action,
        mutation: mutation,
        report: report ?? this.report,
        comments: comments ?? this.comments,
        error: error != null ? error() : null,
      );

  IssueOverviewState loading(IssueOverviewEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );

  IssueOverviewState success(IssueOverviewEvent event, IssueReport data) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        report: data,
      );

  IssueOverviewState failure(IssueOverviewEvent event, Object error) =>
      copyWith(
        action: event,
        mutation: BlocMutation.failure,
        error: () => error,
      );

  IssueOverviewState withComments(
    IssueOverviewEvent event,
    List<IssueComment> data,
  ) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        comments: data,
      );
}
