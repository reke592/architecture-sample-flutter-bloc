part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class LoadTodoList extends TodoListEvent {}

class InsertRecentlyCreated extends TodoListEvent {
  final Todo value;
  InsertRecentlyCreated(this.value);
}

class ReplaceRecentlyUpdated extends TodoListEvent {
  final Todo value;
  ReplaceRecentlyUpdated(this.value);
}

class RemoveTodoItem extends TodoListEvent {
  final Todo value;
  RemoveTodoItem(this.value);
}
