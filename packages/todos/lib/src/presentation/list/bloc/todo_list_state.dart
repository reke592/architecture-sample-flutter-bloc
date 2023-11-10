part of 'todo_list_bloc.dart';

@immutable
class TodoListState extends Equatable {
  final TodoListEvent? action;
  final BlocMutation mutation;
  final List<Todo> data;
  final Object? error;

  const TodoListState({
    this.mutation = BlocMutation.initial,
    this.action,
    this.data = const [],
    this.error,
  });

  @override
  List<Object?> get props => [data, error, action, mutation];

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  TodoListState copyWith({
    required TodoListEvent action,
    required BlocMutation mutation,
    List<Todo>? data,
    Object? Function()? error,
  }) =>
      TodoListState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  TodoListState success(TodoListEvent event, List<Todo> data) => copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  TodoListState failure(TodoListEvent event, Object error) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
        error: () => error,
      );

  TodoListState loading(TodoListEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );
}
