import 'package:ddd_commons/ddd_commons.dart';

class Todo extends Equatable {
  final int? id;
  final String task;
  final bool completed;
  final DateTime? created;
  final DateTime? updated;

  const Todo({
    this.id,
    this.task = '',
    this.completed = false,
    this.created,
    this.updated,
  });

  @override
  List<Object?> get props => [
        task,
        completed,
        created,
        updated,
      ];

  Todo copyWith({
    int? id,
    String? task,
    bool? completed,
    DateTime? created,
    DateTime? updated,
  }) =>
      Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        completed: completed ?? this.completed,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );

  /// object clone
  Todo clone() => Todo(
        id: id,
        task: task,
        completed: completed,
        created: created,
        updated: updated,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        task: json['task'],
        completed: json['completed'] == true,
        created: DateTime.tryParse(json['created'] ?? ''),
        updated: DateTime.tryParse(json['updated'] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'task': task,
        'completed': completed,
        'created': created?.toIso8601String(),
        'updated': updated?.toIso8601String(),
      };
}
