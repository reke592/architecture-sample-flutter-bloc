import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/widgets.dart';

part 'message_bus_event.dart';
part 'message_bus_result.dart';

part 'topics/employee_dropdown_option.dart';

/// Global message bus mixin for repositories, facilitating communication among blocs within a bounded context.
///
/// usage:
/// ```dart
/// class HRRepository with MessageBus {
///   late final _busEventListener = getBusEvents().listen((event) {
///     if (event is EmployeeDropdownOptionRequest) {
///       doSomething().then((result) {
///         busResult.add(EmployeeDropdownOptionResult(
///           request: event,
///           value: result
///         ));
///       });
///     }
///   });
/// }
///
/// class ManpowerRepository with MessageBus {
///   // ... etc, methods, domain event stream
/// }
///
/// class ManpowerBloc extends Bloc<ManpowerEvent, ManpowerState> {
///   late final StreamSubscription<MessageBusResult> _messageBusResultListener;
///
///   ManpowerBloc(ManpowerRepository repo) {
///     on<FormLoad>(_onFormLoad);
///     on<UseEmployeeSelection>(_onUseEmployeeSelection);
///     _messageBusResultListener = repo.getBusResults().listen((event) {
///       if (event is EmployeeDropdownOptionResult && event.request.sender == this) {
///         add(UseEmployeeSelection(value: event.value));
///       }
///     });
///   }
///
///   _onFormLoad(event, emit) {
///     _repo.busEvent.add(EmployeeDropdownOptionRequest(sender: this));
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
mixin MessageBus on Object {
  static final _busEvent = PublishSubject<MessageBusEvent>();
  static final _busResult = PublishSubject<MessageBusResult>();

  PublishSubject<MessageBusEvent> get busEvent => MessageBus._busEvent;
  PublishSubject<MessageBusResult> get busResult => MessageBus._busResult;

  Stream<MessageBusEvent> getBusEvents() => busEvent.stream.asBroadcastStream();
  Stream<MessageBusResult> getBusResults() =>
      busResult.stream.asBroadcastStream();
}
