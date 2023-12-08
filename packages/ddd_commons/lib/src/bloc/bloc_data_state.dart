import 'package:ddd_commons/ddd_commons.dart';

/// {@template data_state}
/// TODO:
/// EXPERIMENTAL common class to reduce bloc boiler plate.
///
/// pros:
/// - less code to write for state class
/// ```dart
/// typedef SampleState = BlocDataState<Sample, SampleBlocEvent>;
///
/// class SampleStateInitial extends SampleState {
///   const SampleStateInitial({super.data = const Sample()});
/// }
/// ```
/// - common pattern to follow inside bloc event handlers
/// ```dart
/// try {
///   emit(state.loading(event));
///   final data = await _repo.loadRecords();
///   emit(state.success(event, data));
/// } catch(error) {
///   emit(state.failure(event, error));
///   rethrow;
/// }
/// ```
/// - more flexible when used in buildWhen and listenWhen, since we use the action and mutation in conditions
/// ```dart
/// listenWhen: (_, current) => current.action is LoadList || current.action is SubmitForm
/// listener: (context, state) {
///   if (state.isSuccess) {
///     if (state.action is SubmitForm) {
///       context.read<SampleFormBloc>().add(ResetSampleForm());
///     }
///   }
///   else if (state.isFailure) {
///     if (state.action is SubmitForm) {
///       MesageDialog.showError(context, state.error!);
///     }
///   }
/// }
/// ```
///
/// cons:
/// - added complexity, since we always need a class definition that extends to typedef.
/// - added complexity, since we can only use the methods `success`,`loading`,`failure` when updating the state
/// - this class reduce the flexibility of state, because we are forced to centralize the properties in [T] model,
///   may also result to anemic domain model since we may leak the form requirements in domain layer. *eg.* a state field to check if the form is ready.
/// - filtering in buildWhen and listenWhen sometimes confusing if we dont supply the right action type.
///
/// common state with fixed properties
/// - [T] data
/// - [TEvent] action
/// - [Object] error
/// - [BlocMutation] mutation
/// {@endtemplate}
class BlocDataState<T, TEvent> extends Equatable {
  final T data;
  final TEvent? action;
  final Object? error;
  final BlocMutation mutation;

  /// {@macro data_state}
  const BlocDataState({
    required this.data,
    this.action,
    this.error,
    this.mutation = BlocMutation.initial,
  });

  @override
  List<Object?> get props => [data, error, action, mutation];

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  BlocDataState<T, TEvent> copyWith({
    required TEvent action,
    required BlocMutation mutation,
    T? data,
    Object? Function()? error,
  }) =>
      BlocDataState(
        action: action,
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  BlocDataState<T, TEvent> loading(TEvent event) => copyWith(
        action: event,
        mutation: BlocMutation.loading,
      );

  BlocDataState<T, TEvent> success(TEvent event, T data) => copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: data,
      );

  BlocDataState<T, TEvent> failure(TEvent event, Object error) => copyWith(
        action: event,
        mutation: BlocMutation.failure,
        error: () => error,
      );
}
