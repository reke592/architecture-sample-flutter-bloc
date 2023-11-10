import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';

class ButtonSubmitTodo extends StatelessWidget {
  const ButtonSubmitTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosFormBloc, TodosFormState>(
      buildWhen: (_, current) =>
          current.action is LoadDetails || current.action is SubmitForm,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<TodosFormBloc>().add(SubmitForm());
                },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        );
      },
    );
  }
}
