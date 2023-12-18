part of 'topics.dart';

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
class EmployeeDropdownOptionRequest
    extends ListRequest<EmployeeDropdownOption> {
  const EmployeeDropdownOptionRequest({required super.sender});
}

@immutable
class EmployeeDropdownOptionResult
    extends ListResponse<EmployeeDropdownOption> {
  const EmployeeDropdownOptionResult({
    required super.request,
    required super.data,
  });
}
