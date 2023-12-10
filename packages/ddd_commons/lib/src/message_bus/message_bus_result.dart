part of 'message_bus.dart';

/// Base class for global message result
@immutable
abstract class MessageBusResult {
  /// optional field, allowing the request sender to verify its identity.
  final MessageBusEvent? request;
  const MessageBusResult({this.request});
}
