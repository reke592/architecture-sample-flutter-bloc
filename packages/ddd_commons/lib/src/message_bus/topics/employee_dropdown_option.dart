part of '../message_bus.dart';

@immutable
class EmployeeDropdownOption {
  final int id;
  final String name;
  const EmployeeDropdownOption({
    required this.id,
    required this.name,
  });
}

@immutable
class EmployeeDropdownOptionRequest extends MessageBusEvent {
  const EmployeeDropdownOptionRequest({required super.sender});
}

@immutable
class EmployeeDropdownOptionResult extends MessageBusResult {
  final List<EmployeeDropdownOption> value;
  const EmployeeDropdownOptionResult({
    required super.request,
    required this.value,
  });
}
