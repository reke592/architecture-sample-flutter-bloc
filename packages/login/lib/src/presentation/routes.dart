import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/src/presentation/login_page.dart';

ShellRoute configureLoginRoutes(
  GlobalKey<NavigatorState> rootNavigator, {
  String root = '/login',
}) {
  final shellKey = GlobalKey<NavigatorState>();
  return ShellRoute(
    parentNavigatorKey: rootNavigator,
    navigatorKey: shellKey,
    pageBuilder: (context, state, child) => NoTransitionPage(
      child: Scaffold(body: child),
    ),
    routes: [
      GoRoute(
        name: 'login',
        path: root,
        redirect: (context, state) =>
            context.read<LoginCubit>().state.data == LoginStatus.success
                ? '$root/redirect'
                : null,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: '$root/redirect',
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed('dashboard');
          });
          return Container();
        },
      ),
    ],
  );
}
