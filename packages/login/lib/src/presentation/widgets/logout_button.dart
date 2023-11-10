import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (state.data == LoginStatus.expired) {
            context.goNamed('login');
          }
        }
      },
      child: TextButton.icon(
        onPressed: () {
          context.read<LoginCubit>().logout();
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
      ),
    );
  }
}
