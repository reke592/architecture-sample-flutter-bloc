import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:todos/src/presentation/form/bloc/todos_form_bloc.dart';
import 'package:todos/src/presentation/form/widgets/button_submit_todo.dart';
import 'package:todos/src/presentation/form/widgets/checkbox_completed.dart';
import 'package:todos/src/presentation/form/widgets/input_task.dart';

class TodosForm extends StatelessWidget {
  const TodosForm({super.key});

  void onClose(BuildContext context) {
    if (PreviousRouteObserver.routeName != 'Todo List' &&
        Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      context.goNamed('Todo List');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosFormBloc, TodosFormState>(
      listenWhen: (_, current) => current.action is SubmitForm,
      listener: (context, state) {
        if (state.isSuccess) {
          onClose(context);
        } else if (state.isFailure) {
          MessageDialog.showError(context, state.error!);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => onClose(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${GoRouterState.of(context).name}'),
              const PreviousRouteLabel(),
            ],
          ),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const InputTask(),
                  AppTheme.gap1,
                  const CheckBoxCompletedTodo(),
                  const ButtonSubmitTodo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
