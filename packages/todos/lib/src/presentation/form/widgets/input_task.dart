import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';

class InputTask extends StatelessWidget {
  const InputTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosFormBloc, TodosFormState>(
      buildWhen: (_, current) => current.action is LoadDetails,
      builder: (context, state) {
        return TextField(
          maxLines: 5,
          controller: TextEditingController(text: state.data.task),
          decoration: const InputDecoration(
            labelText: 'Task description',
          ),
          onChanged: (value) {
            context.read<TodosFormBloc>().add(UpdateTaskValue(value));
          },
        ).addShimmer(state.isLoading);
      },
    );
  }
}
