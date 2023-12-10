part of 'message_bus.dart';

/// Base class for global message event
@immutable
abstract class MessageBusEvent {
  /// the object instance that submits this message
  ///
  /// sender can later verify itself upon receiving a [MessageBusEvent] as result.
  final Object sender;
  const MessageBusEvent({required this.sender});
}
