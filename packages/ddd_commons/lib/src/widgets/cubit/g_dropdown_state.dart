part of 'g_dropdown_cubit.dart';

@immutable
class GDropdownState<T> {
  final ListRequest<T>? request;
  final BlocMutation mutation;
  final List<T> data;
  final Object? error;

  const GDropdownState({
    this.mutation = BlocMutation.initial,
    this.request,
    this.data = const [],
    this.error,
  });

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  GDropdownState<T> copyWith({
    required BlocMutation mutation,
    ListRequest<T>? request,
    List<T>? data,
    Object? Function()? error,
  }) =>
      GDropdownState<T>(
        mutation: mutation,
        request: request ?? this.request,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  GDropdownState<T> loading(ListRequest<T> request) => copyWith(
        mutation: BlocMutation.loading,
        request: request,
      );

  GDropdownState<T> success(List<T> data) => copyWith(
        mutation: BlocMutation.success,
        data: data,
      );

  GDropdownState<T> failure(Object error) => copyWith(
        mutation: BlocMutation.failure,
        error: () => error,
      );
}
