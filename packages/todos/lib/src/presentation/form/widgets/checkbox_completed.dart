import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';

class CheckBoxCompletedTodo extends StatelessWidget {
  const CheckBoxCompletedTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosFormBloc, TodosFormState>(
      buildWhen: (_, current) =>
          current.action is LoadDetails ||
          current.action is UpdateCompletedValue,
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.data.completed,
              onChanged: (value) {
                context
                    .read<TodosFormBloc>()
                    .add(UpdateCompletedValue(value == true));
              },
            ),
            const Text('Completed'),
          ],
        ).addShimmer(state.isLoading);
      },
    );
  }
}
