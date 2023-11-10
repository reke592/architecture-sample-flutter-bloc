import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/presentation/list/bloc/todo_list_bloc.dart';

class ButtonReloadTodoList extends StatelessWidget {
  const ButtonReloadTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      buildWhen: (_, current) => current.action is LoadTodoList,
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<TodoListBloc>().add(LoadTodoList());
          },
          icon: state.isLoading
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.refresh, size: 16),
        );
      },
    );
  }
}
