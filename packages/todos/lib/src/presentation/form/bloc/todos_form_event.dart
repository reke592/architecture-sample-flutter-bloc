part of 'todos_form_bloc.dart';

@immutable
abstract class TodosFormEvent {}

class LoadDetails extends TodosFormEvent {
  final int? id;
  LoadDetails(this.id);
}

class UpdateTaskValue extends TodosFormEvent {
  final String value;
  UpdateTaskValue(this.value);
}

class UpdateCompletedValue extends TodosFormEvent {
  final bool value;
  UpdateCompletedValue(this.value);
}

class SubmitForm extends TodosFormEvent {}

class FormSubmitted extends TodosFormEvent {
  final Todo value;
  final bool isNewRecord;
  FormSubmitted({
    required this.value,
    required this.isNewRecord,
  });
}
