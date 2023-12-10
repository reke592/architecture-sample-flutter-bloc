part of 'topics.dart';

@immutable
class SessionInfo {
  final String username;
  const SessionInfo({
    required this.username,
  });
}

@immutable
class SessionInfoRequest extends MessageBusEvent {
  const SessionInfoRequest({required super.sender});
}

@immutable
class SessionInfoResult extends MessageBusResult {
  final SessionInfo value;
  const SessionInfoResult({
    required super.request,
    required this.value,
  });
}
