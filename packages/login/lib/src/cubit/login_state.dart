part of 'login_cubit.dart';

@immutable
class LoginState extends Equatable {
  final BlocMutation mutation;

  /// ftmt we use enum for testing
  final LoginStatus data;

  final Object? error;

  const LoginState({
    this.mutation = BlocMutation.initial,
    this.data = LoginStatus.unknown,
    this.error,
  });

  @override
  List<Object?> get props => [data, mutation];

  bool get isInitial => mutation == BlocMutation.initial;
  bool get isLoading => mutation == BlocMutation.loading;
  bool get isSuccess => mutation == BlocMutation.success;
  bool get isFailure => mutation == BlocMutation.failure;

  LoginState copyWith({
    required BlocMutation mutation,
    LoginStatus? data,
    Object? Function()? error,
  }) =>
      LoginState(
        mutation: mutation,
        data: data ?? this.data,
        error: error != null ? error() : this.error,
      );

  LoginState success(LoginStatus data) => copyWith(
        mutation: BlocMutation.success,
        data: data,
      );

  LoginState loading() => copyWith(
        mutation: BlocMutation.loading,
      );

  LoginState failed(Object error) => copyWith(
        mutation: BlocMutation.failure,
        error: () => error,
      );
}
