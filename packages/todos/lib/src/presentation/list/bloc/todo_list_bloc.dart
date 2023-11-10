import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';
import 'package:todos/src/domain/models/todo.dart';
import 'package:todos/src/domain/todos_repository.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

typedef _E = Emitter<TodoListState>;

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  late final StreamSubscription<TodosFormEvent> _formSubscription;
  final TodosRepository _repo;

  TodoListBloc({
    required TodosRepository todosRepo,
  })  : _repo = todosRepo,
        super(const TodoListState()) {
    on<LoadTodoList>(_onLoadTodoList);
    on<InsertRecentlyCreated>(_onInsertRecentlyCreated);
    on<ReplaceRecentlyUpdated>(_onReplaceRecentlyUpdated);
    _formSubscription = todosRepo.getFormEvent().listen((event) {
      if (event is FormSubmitted) {
        if (event.isNewRecord) {
          add(InsertRecentlyCreated(event.value));
        } else {
          add(ReplaceRecentlyUpdated(event.value));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await _formSubscription.cancel();
    return super.close();
  }

  _onInsertRecentlyCreated(InsertRecentlyCreated event, _E emit) {
    emit(state.success(event, List<Todo>.from(state.data)..add(event.value)));
  }

  _onReplaceRecentlyUpdated(ReplaceRecentlyUpdated event, _E emit) {
    final index =
        state.data.indexWhere((element) => element.id == event.value.id);
    if (index > -1) {
      final updated = List<Todo>.from(state.data);
      updated[index] = event.value;
      emit(state.success(event, updated));
    }
  }

  _onLoadTodoList(LoadTodoList event, _E emit) async {
    try {
      emit(state.loading(event));
      final data = await _repo.getList();
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }
}
