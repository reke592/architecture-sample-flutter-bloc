import 'package:todos/src/domain/models/todo.dart';
import 'package:todos/src/domain/todos_repository.dart';

class TodosMemoryRepository extends TodosRepository {
  final Duration responseThrottle;
  final List<Todo> _todos = [
    Todo(
      id: 1,
      task: 'sample',
      created: DateTime.now(),
    ),
  ];

  TodosMemoryRepository({
    this.responseThrottle = const Duration(seconds: 1),
  });

  /// we use clone for testing purpose to avoid reference object mutation
  @override
  Future<Todo> create(Todo value) async {
    await Future.delayed(responseThrottle);
    final record = value.clone().copyWith(
          id: _todos.length + 1,
          created: DateTime.now(),
        );
    _todos.add(record);
    return record;
  }

  @override
  Future<Todo> delete(Todo value) async {
    await Future.delayed(responseThrottle);
    _todos.removeWhere((element) => element.id == value.id);
    return value;
  }

  @override
  Future<List<Todo>> getList() async {
    await Future.delayed(responseThrottle);
    return List<Todo>.from(_todos);
  }

  @override
  Future<Todo> update(Todo value) async {
    await Future.delayed(responseThrottle);
    final index = _todos.indexWhere((element) => element.id == value.id);
    if (index < 0) {
      throw Exception('Record not found');
    }
    final updated = value.clone().copyWith(updated: DateTime.now());
    _todos[index] = updated;
    return updated;
  }

  @override
  Future<Todo> getDetails(int id) async {
    await Future.delayed(responseThrottle);
    final index = _todos.indexWhere((element) => element.id == id);
    if (index < 0) {
      throw Exception('Record not found');
    }
    return _todos[index].clone();
  }
}
