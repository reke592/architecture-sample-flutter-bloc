import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:login/src/cubit/login_cubit.dart';
import 'package:login/src/domain/enums/login_status.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess && state.data == LoginStatus.success) {
          context.goNamed('dashboard');
        } else if (state.isFailure) {
          MessageDialog.showError(context, state.error!);
        }
      },
      builder: (context, state) {
        String username = '';
        String password = '';
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'User Login',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    AppTheme.gap1,
                    TextField(
                      decoration: const InputDecoration(label: Text('Username')),
                      onChanged: (value) => username = value,
                    ),
                    AppTheme.gap1,
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(label: Text('Password')),
                      onChanged: (value) => password = value,
                    ),
                    AppTheme.gap1,
                    Text(
                      'sample account username: admin, password: admin',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    AppTheme.gap1,
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<LoginCubit>().basicLogin(
                              username: username,
                              password: password,
                            );
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
