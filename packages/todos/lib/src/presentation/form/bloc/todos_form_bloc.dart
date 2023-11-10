import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';
import 'package:todos/src/domain/models/todo.dart';
import 'package:todos/src/domain/todos_repository.dart';

part 'todos_form_event.dart';
part 'todos_form_state.dart';

typedef _E = Emitter<TodosFormState>;

class TodosFormBloc extends Bloc<TodosFormEvent, TodosFormState> {
  final TodosRepository _repo;

  TodosFormBloc({
    required TodosRepository todosRepo,
  })  : _repo = todosRepo,
        super(const TodosFormState()) {
    on<LoadDetails>(_onLoadDetails);
    on<UpdateTaskValue>(_onUpdateTaskValue, transformer: restartable());
    on<SubmitForm>(_onSubmitForm);
    on<UpdateCompletedValue>(_onUpdateCompletedValue);
  }

  _onUpdateCompletedValue(UpdateCompletedValue event, _E emit) {
    emit(state.success(event, state.data.copyWith(completed: event.value)));
  }

  _onSubmitForm(SubmitForm event, _E emit) async {
    try {
      emit(state.loading(event));
      bool isNewRecord = state.data.id == null;
      Todo result = isNewRecord
          ? await _repo.create(state.data)
          : await _repo.update(state.data);
      _repo.formEvent.add(FormSubmitted(
        value: result,
        isNewRecord: isNewRecord,
      ));
      emit(state.success(event, result));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }

  _onUpdateTaskValue(UpdateTaskValue event, _E emit) {
    emit(state.success(event, state.data.copyWith(task: event.value)));
  }

  _onLoadDetails(LoadDetails event, _E emit) async {
    try {
      if (event.id == null) return;
      emit(state.loading(event));
      final data = await _repo.getDetails(event.id!);
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }
}
