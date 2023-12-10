import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/widgets.dart';

part 'message_bus_event.dart';
part 'message_bus_result.dart';

/// Contract for repositories utilizing global message bus to ensure consistency
abstract class MessageBus {
  final MessageBusRepository bus;
  MessageBus({required this.bus});
}

/// {@template message_bus_repository}
/// Global message bus for repositories, facilitating communication among blocs within a bounded context.
///
/// usage:
/// ```dart
/// class HRRepositoryImpl extends HRRepository {
///   HRRepositoryImpl({required super.bus});
/// }
///
/// class ManpowerRepositoryImpl extends ManpowerRepository {
///   HRRepositoryImpl({required super.bus});
/// }
///
/// abstract class HRRepository extends MessageBus {
///   HRRepository({required this.bus});
///
///   late final _busEventListener = bus.getEvents().listen((event) {
///     if (event is EmployeeDropdownOptiequest) {
///       doSomething().then((result) {
///         bus.addResult(EmployeeDropdownOptionResult(
///           request: event,
///           value: result
///         ));
///       });
///     }
///   });
/// }
///
/// abstract class ManpowerRepository extends MessageBus {
///   ManpowerRepository({required this.bus});
///   // ... etc, methods, domain event stream
/// }
///
/// class ManpowerBloc extends Bloc<ManpowerEvent, ManpowerState> {
///   late final StreamSubscription<MessageBusResult> _messageBusResultListener;
///
///   ManpowerBloc(ManpowerRepository repo) {
///     on<FormLoad>(_onFormLoad);
///     on<UseEmployeeSelection>(_onUseEmployeeSelection);
///     _messageBusResultListener = repo.bus.getResults().listen((event) {
///       if (event is EmployeeDropdownOptionResult && event.request.sender == this) {
///         add(UseEmployeeSelection(value: event.value));
///       }
///     });
///   }
///
///   _onFormLoad(event, emit) {
///     _repo.bus.addEvent(EmployeeDropdownOptionRequest(sender: this));
///   }
///
///   _onUseEmployeeSelection(event, emit) {
///     emit(state.copyWith({
///       employeeSelection: event.value,
///     }));
///   }
/// }
///
/// ```
/// {@endtemplate}
abstract class MessageBusRepository {
  Stream<MessageBusEvent> getEvents();
  Stream<MessageBusResult> getResults();
  void addEvent(MessageBusEvent event);
  void addResult(MessageBusResult result);
}

/// {@macro message_bus_repository}
class MessageBusRepositoryImpl implements MessageBusRepository {
  final _event = PublishSubject<MessageBusEvent>();
  final _result = PublishSubject<MessageBusResult>();

  /// {@macro message_bus_repository}
  MessageBusRepositoryImpl();

  void dispose() {
    _event.close();
    _result.close();
  }

  @override
  void addEvent(MessageBusEvent event) {
    _event.add(event);
  }

  @override
  void addResult(MessageBusResult result) {
    _result.add(result);
  }

  @override
  Stream<MessageBusEvent> getEvents() => _event.stream.asBroadcastStream();

  @override
  Stream<MessageBusResult> getResults() => _result.stream.asBroadcastStream();
}
