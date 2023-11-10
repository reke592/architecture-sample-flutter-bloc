part of 'todos_form_bloc.dart';

@immutable
class TodosFormState extends Equatable {
  final Todo data;
  final TodosFormEvent? action;
  final BlocMutation mutation;
  final Object? error;

  const TodosFormState({
    this.data = const Todo(),
    this.action,
    this.mutation = BlocMutation.initial,
    this.error,
  });

  @override
  List<Object?> get props => [data, error, action, mutation];

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  TodosFormState copyWith({
    required TodosFormEvent action,
    required BlocMutation mutation,
    Todo? data,
    Object? Function()? error,
  }) =>
      TodosFormState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  TodosFormState success(TodosFormEvent event, Todo data) => copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  TodosFormState failure(TodosFormEvent event, Object error) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
        error: () => error,
      );

  TodosFormState loading(TodosFormEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );
}
