import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/domain/todos_repository.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';
import 'package:todos/src/presentation/form/todos_form.dart';
import 'package:todos/src/presentation/list/bloc/todo_list_bloc.dart';
import 'package:todos/src/presentation/list/todo_list_page.dart';
import 'package:todos/src/presentation/widgets/button_create_todo.dart';

ShellRoute configureTodosRoutes(
  GlobalKey<NavigatorState> rootNavigator, {
  String root = '/todos',
}) {
  final shellKey = GlobalKey<NavigatorState>();
  return ShellRoute(
    parentNavigatorKey: rootNavigator,
    navigatorKey: shellKey,
    observers: [PreviousRouteObserver()],
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
        child: BlocProvider(
          create: (context) => TodoListBloc(
            todosRepo: context.read<TodosRepository>(),
          )..add(LoadTodoList()),
          child: MediaQuery.orientationOf(context) == Orientation.landscape
              // display navigated route beside the list
              ? TodoListPage(child: child)
              // display the actual widget in page route
              : child,
        ),
      );
    },
    routes: [
      GoRoute(
        name: 'Todo List',
        path: root,
        builder: (context, state) =>
            MediaQuery.orientationOf(context) == Orientation.landscape
                // list is always visible
                // display the create button beside todo list
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [ButtonCreateTodo()],
                    ),
                  )
                // occupy the whole page
                : const Scaffold(
                    body: TodoListPage(),
                    floatingActionButton: ButtonCreateTodo(),
                  ),
      ),
      GoRoute(
        name: 'new Todo',
        path: '$root/new',
        builder: (context, state) => BlocProvider(
          create: (context) => TodosFormBloc(
            todosRepo: context.read<TodosRepository>(),
          ),
          child: const TodosForm(),
        ),
      ),
      GoRoute(
        name: 'view Todo',
        path: '$root/:id/view',
        builder: (context, state) => BlocProvider(
          create: (context) => TodosFormBloc(
            todosRepo: context.read<TodosRepository>(),
          )..add(LoadDetails(int.tryParse(state.pathParameters['id'] ?? ''))),
          child: const TodosForm(),
        ),
      ),
    ],
  );
}
