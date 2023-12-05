part of 'issue_comment_bloc.dart';

@immutable
class IssueCommentState {
  final IssueCommentEvent? action;
  final BlocMutation mutation;
  final IssueComment data;
  final Object? error;

  const IssueCommentState({
    this.action,
    this.mutation = BlocMutation.initial,
    this.data = const IssueComment(),
    this.error,
  });

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  IssueCommentState copyWith({
    required IssueCommentEvent action,
    required BlocMutation mutation,
    IssueComment? data,
    Object? Function()? error,
  }) =>
      IssueCommentState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  IssueCommentState loading(IssueCommentEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );

  IssueCommentState success(IssueCommentEvent event, IssueComment data) =>
      copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  IssueCommentState failure(IssueCommentEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
      );
}
