import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/domain/models/todo.dart';
import 'package:todos/src/presentation/list/bloc/todo_list_bloc.dart';
import 'package:todos/src/presentation/widgets/button_reload_todo_list.dart';

class TodoListPage extends StatelessWidget {
  final Widget child;

  const TodoListPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Text('Todos')],
        ),
        leading: BackButton(onPressed: () {
          context.goNamed('dashboard');
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Spacer(),
                      ButtonReloadTodoList(),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<TodoListBloc, TodoListState>(
                      buildWhen: (_, current) =>
                          current.action is LoadTodoList ||
                          current.action is InsertRecentlyCreated ||
                          current.action is ReplaceRecentlyUpdated,
                      builder: (context, state) {
                        if (state.isFailure) {
                          return Text('${state.error}');
                        }

                        final data = state.isLoading
                            ? List.generate(
                                3,
                                (index) => Todo(
                                    id: index, task: 'Task description...'))
                            : state.data;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final todo = data[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: ListTile(
                                dense: true,
                                tileColor:
                                    state.isLoading ? Colors.transparent : null,
                                title: Text(todo.task),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(todo.id.toString().padLeft(6, '0')),
                                    Text('Created ${todo.created}'),
                                    Text('Updated ${todo.updated ?? '--'}')
                                  ],
                                ),
                                trailing: Icon(
                                  todo.completed
                                      ? Icons.check_circle
                                      : Icons.pending,
                                ),
                                onTap: () {
                                  context
                                      .pushNamed('view Todo', pathParameters: {
                                    'id': todo.id.toString(),
                                  });
                                },
                              ),
                            );
                          },
                        ).addShimmer(state.isLoading);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            // form view
            Expanded(
              flex: 4,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
