import 'package:ddd_commons/ddd_commons.dart';
import 'package:todos/src/domain/models/todo.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';

abstract class TodosRepository extends MessageBus {
  final formEvent = PublishSubject<TodosFormEvent>();

  TodosRepository({required super.bus});

  Stream<TodosFormEvent> getFormEvent() => formEvent.stream.asBroadcastStream();

  Future<List<Todo>> getList();
  Future<Todo> getDetails(int id);
  Future<Todo> create(Todo value);
  Future<Todo> update(Todo value);
  Future<Todo> delete(Todo value);
}
