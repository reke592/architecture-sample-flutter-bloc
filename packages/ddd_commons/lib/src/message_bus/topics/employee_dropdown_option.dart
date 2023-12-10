part of '../message_bus.dart';

class EmployeeDropdownOption {
  final int id;
  final String name;
  EmployeeDropdownOption({
    required this.id,
    required this.name,
  });
}

class EmployeeDropdownOptionRequest extends MessageBusEvent {
  const EmployeeDropdownOptionRequest({required super.sender});
}

class EmployeeDropdownOptionResult extends MessageBusResult {
  final List<EmployeeDropdownOption> value;
  const EmployeeDropdownOptionResult({
    required super.request,
    required this.value,
  });
}
