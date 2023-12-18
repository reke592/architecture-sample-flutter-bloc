import 'package:ddd_commons/src/message_bus/message_bus.dart';
import 'package:flutter/foundation.dart';

part 'session_info.dart';
part 'employee_dropdown_option.dart';

abstract class ListRequest<T> extends MessageBusEvent {
  const ListRequest({required super.sender});
}

abstract class ListResponse<T> extends MessageBusResult {
  final List<T> data;
  const ListResponse({super.request, required this.data});
}
