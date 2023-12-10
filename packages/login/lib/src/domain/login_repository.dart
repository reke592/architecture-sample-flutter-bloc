import 'package:ddd_commons/ddd_commons.dart';

import 'enums/login_status.dart';

abstract class LoginRepository extends MessageBus {
  /// emitter for status event
  final statusEvent = PublishSubject<LoginStatus>();

  LoginRepository({required super.bus});

  /// domain event for login status to consume by logic components
  Stream<LoginStatus> getStatus() => statusEvent.stream.asBroadcastStream();

  /// basic login
  Future<void> basicLogin({
    required String username,
    required String password,
  });

  Future<void> logout();
}
